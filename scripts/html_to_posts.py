#!/usr/bin/env python3
"""Convert a publication list (HTML or plain text) into Jekyll post files.

Usage:
    python scripts/html_to_posts.py input.html [--dry-run] [--log LOG_FILE]
    python scripts/html_to_posts.py publication.txt [--dry-run] [--log LOG_FILE]

HTML format: year headings (<h3>2023</h3>) followed by <ul><li>…</li></ul>
Text format: tab-separated  "N\\tcitation_text"  one entry per line.

The script uses the ORIGINAL author list from the source file (the preferred
author list), and fetches title/journal/date from CrossRef when the DOI lookup
returns a matching paper. If CrossRef returns a different paper, it falls back
to parsing the citation text directly.

A detailed log is written showing: original record, CrossRef query results,
preferred author list, and final output for each entry.
"""

import html
import os
import re
import sys
import time
import unicodedata
import urllib.parse
import urllib.request
import json
from html.parser import HTMLParser


# ---------------------------------------------------------------------------
# HTML parsing
# ---------------------------------------------------------------------------

class PubListParser(HTMLParser):
    """Extract (year, raw_text) pairs from the publication HTML."""

    def __init__(self):
        super().__init__()
        self._current_year = None
        self._in_li = False
        self._li_text = ""
        self.entries = []  # list of (year, text)
        self._tag_stack = []

    def handle_starttag(self, tag, attrs):
        tag = tag.lower()
        self._tag_stack.append(tag)
        if tag == "li":
            self._in_li = True
            self._li_text = ""

    def handle_endtag(self, tag):
        tag = tag.lower()
        if tag == "li" and self._in_li:
            self._in_li = False
            text = self._li_text.strip()
            if text:
                self.entries.append((self._current_year, text))
        if tag in ("h3", "h2", "h4"):
            pass  # year captured via handle_data
        if self._tag_stack and self._tag_stack[-1] == tag:
            self._tag_stack.pop()

    def handle_data(self, data):
        if self._in_li:
            self._li_text += data
        # Detect year headings
        if self._tag_stack and self._tag_stack[-1] in ("h2", "h3", "h4"):
            m = re.search(r"((?:19|20)\d{2})", data)
            if m:
                self._current_year = m.group(1)


def parse_html(html_text):
    """Return list of (year:str, citation_text:str)."""
    parser = PubListParser()
    parser.feed(html_text)
    return parser.entries


def parse_text(text):
    """Parse plain-text publication list in 'N\\tcitation' tab format.

    Returns list of (year:str|None, citation_text:str).
    Year is extracted from the citation text if available.
    """
    entries = []
    for line in text.splitlines():
        line = line.strip()
        if not line:
            continue
        # Lines are "N\tcitation" or just a citation
        if '\t' in line:
            _, citation = line.split('\t', 1)
        else:
            # Might start with "N " (space-separated number)
            m = re.match(r'^\d+\s+(.*)', line)
            citation = m.group(1) if m else line
        citation = citation.strip()
        if citation:
            year = _extract_year_hint(citation)
            entries.append((year, citation))
    return entries


def _extract_year_hint(text):
    """Try to guess the publication year from a citation string.

    Looks for 4-digit years after known date patterns or DOIs.
    Returns a string year like '2023' or None.
    """
    # Patterns tried in priority order (most specific first)
    for pattern in [
        r'\b(20\d{2}|19\d{2})\s+(?:Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)\b',
        r'(?:Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)\s+(20\d{2}|19\d{2})\b',
        r'\(\s*(20\d{2}|19\d{2})\s*\)',   # parenthesized year like "(2024)"
        r'[;,.]\s*(20\d{2}|19\d{2})\b',
        r'\b(20\d{2}|19\d{2})\b',          # bare year as last resort
    ]:
        m = re.search(pattern, text)
        if m:
            year = m.group(1)
            # Sanity check: year should be plausible (not future)
            if 1990 <= int(year) <= 2026:
                return year
    return None


def detect_format(content):
    """Return 'html' or 'text' based on file content."""
    stripped = content.lstrip()
    if stripped.startswith('<') or '<html' in stripped[:500].lower() or '<ul>' in stripped[:500]:
        return 'html'
    return 'text'


# ---------------------------------------------------------------------------
# DOI extraction
# ---------------------------------------------------------------------------

_DOI_RE = re.compile(r'(?:doi:\s*|https?://doi\.org/)(10\.\S+)', re.IGNORECASE)


def extract_doi(text):
    """Return bare DOI string (e.g. '10.1038/…') or None."""
    m = _DOI_RE.search(text)
    if not m:
        return None
    doi = m.group(1).rstrip(".,;:) ")
    # A valid DOI must contain a '/' after the prefix (e.g. 10.1038/xxxxx).
    # Reject truncated DOIs like bare "10.1038".
    if "/" not in doi:
        return None
    return doi


# ---------------------------------------------------------------------------
# CrossRef metadata
# ---------------------------------------------------------------------------

def _crossref_request(url, retries=3):
    """Make a request to CrossRef. Returns parsed JSON message or None."""
    headers = {"User-Agent": "RenLabWebsite/1.0 (mailto:bing.ren@example.com)"}
    for attempt in range(retries):
        try:
            req = urllib.request.Request(url, headers=headers)
            with urllib.request.urlopen(req, timeout=15) as resp:
                data = json.loads(resp.read().decode())
            return data.get("message", {})
        except Exception as exc:
            print(f"  CrossRef attempt {attempt+1}: {exc}", file=sys.stderr)
            time.sleep(1.5 * (attempt + 1))
    return None


def fetch_crossref(doi, retries=3):
    """Fetch metadata dict from CrossRef for *doi*. Returns None on failure."""
    url = f"https://api.crossref.org/works/{doi}"
    return _crossref_request(url, retries)


def _title_words(text):
    """Extract significant words from a title (lowercase, 4+ chars)."""
    words = re.findall(r'[a-z]{4,}', text.lower())
    # Exclude very common words
    stop = {"this", "that", "with", "from", "have", "been", "were", "will",
            "into", "than", "also", "their", "which", "when", "about", "each",
            "both", "does", "here", "they", "these", "those", "through", "during",
            "between", "using", "upon"}
    return set(w for w in words if w not in stop)


def validate_crossref_match(cr_title, original_text):
    """Check that a CrossRef title actually matches the original citation.

    Returns True if the titles share enough significant words.
    """
    ref_words = _title_words(original_text)
    cr_words = _title_words(cr_title)
    if not cr_words:
        return False
    overlap = ref_words & cr_words
    # Require at least 3 significant words in common
    # AND at least 40% of the CrossRef title words must be in the original
    if len(overlap) >= 3 and len(overlap) >= len(cr_words) * 0.4:
        return True
    return False


def metadata_from_crossref(msg):
    """Extract (title, authors_str, journal, year, month, day) from CrossRef message."""
    title = ""
    if msg.get("title"):
        title = msg["title"][0]

    authors_parts = []
    for a in msg.get("author", []):
        given = a.get("given", "")
        family = a.get("family", "")
        authors_parts.append(f"{given} {family}".strip())
    authors = ", ".join(authors_parts)

    journal = ""
    for key in ("container-title", "short-container-title"):
        val = msg.get(key)
        if val:
            journal = val[0] if isinstance(val, list) else val
            break

    year, month, day = None, 1, 1
    for date_key in ("published-print", "published-online", "published", "created"):
        dp = msg.get(date_key, {}).get("date-parts")
        if dp and dp[0]:
            parts = dp[0]
            year = parts[0] if len(parts) > 0 else None
            month = parts[1] if len(parts) > 1 else 1
            day = parts[2] if len(parts) > 2 else 1
            break

    return title, authors, journal, year, month, day


# ---------------------------------------------------------------------------
# Extract preferred author list from HTML citation text
# ---------------------------------------------------------------------------

def extract_authors_from_citation(text):
    """Extract the author list from a citation in various formats.

    Handles:
    - "Authors. Title. Journal." (modern format)
    - "Authors (YYYY) Title. Journal." (older format)
    - "Authors. (YYYY) Title. Journal."
    - Consortium papers
    - Entries with numbered prefixes like "25. Author..."
    """
    # Remove DOI portion and PMID
    clean = _DOI_RE.sub("", text).strip()
    clean = re.sub(r'\s*PMID:?\s*\d+\s*', ' ', clean)
    # Remove annotations like (* co-corresponding author) or (I am one of ...)
    clean = re.sub(r'\s*\([^)]*co-correspond[^)]*\)', '', clean, flags=re.IGNORECASE)
    clean = re.sub(r'\s*\(I am one[^)]*\)', '', clean, flags=re.IGNORECASE)
    # Remove leading numbered prefixes like "25.    "
    clean = re.sub(r'^\d+\.\s+', '', clean)
    clean = re.sub(r'\s+', ' ', clean).strip(". ")

    # Strategy 1: Look for "(YYYY)" pattern - authors come before it
    year_match = re.search(r'\s*\((?:19|20)\d{2}\)\s*', clean)
    if year_match and year_match.start() < len(clean) * 0.8:
        candidate = clean[:year_match.start()].strip(" ,.")
        if candidate and ("," in candidate or len(candidate.split()) <= 10):
            return candidate

    # Strategy 2: Simple split on ". " — "Authors. Title. Journal."
    # If the first part has commas, it's likely the author list.
    parts = clean.split(". ")
    if len(parts) >= 2:
        candidate = parts[0].strip()
        if "," in candidate:
            return candidate
        # Single-author or consortium: short, no commas
        words = candidate.split()
        if len(words) <= 10:
            return candidate

    # Fallback: return everything before the first obvious title marker
    return ""


# ---------------------------------------------------------------------------
# Slug generation
# ---------------------------------------------------------------------------

def slugify(text, max_len=60):
    text = unicodedata.normalize("NFKD", text)
    text = text.encode("ascii", "ignore").decode()
    text = re.sub(r"[^\w\s-]", "", text.lower())
    text = re.sub(r"[\s_]+", "_", text).strip("_-")
    return text[:max_len].rstrip("_-")


# ---------------------------------------------------------------------------
# Fallback: parse citation text directly
# ---------------------------------------------------------------------------

def _clean_journal(journal):
    """Strip volume/issue/page/date info from journal string."""
    journal = re.sub(r'[\s,.;]*\d+\([\d–-]+\):\S+.*', '', journal)
    journal = re.sub(r'[\s,.;]*\d+\(\d+\).*', '', journal)
    journal = re.sub(r'[\s,.;]*\d{4}\s+\w{3}\b.*', '', journal)
    journal = re.sub(r'[\s,.;]*\d{4}\s+\w+\s+\d+.*', '', journal)
    journal = re.sub(r'[\s,.;]*\d+\(\d+\):\d+.*', '', journal)
    journal = re.sub(r'[\s,.;]*pii:.*', '', journal, flags=re.IGNORECASE)
    journal = re.sub(r'[\s,.;]*PMID:?\s*\d+.*', '', journal)
    journal = re.sub(r'\s*\[Epub.*?\]', '', journal)
    journal = re.sub(r'\s*\(Epub.*?\)', '', journal)
    journal = re.sub(r'[\s,.;]*Online ahead of print.*', '', journal, flags=re.IGNORECASE)
    journal = re.sub(r'[\s,.;]*Epub \d{4}.*', '', journal)
    journal = re.sub(r'\s*\(publication.*?\)', '', journal, flags=re.IGNORECASE)
    return journal.strip(" .,;:")


def parse_citation_text(text, year):
    """Best-effort extraction when CrossRef is unavailable."""
    title = ""
    authors = ""
    journal = ""

    # Remove DOI portion
    clean = _DOI_RE.sub("", text).strip()
    # Remove PMID
    clean = re.sub(r'\s*PMID:?\s*\d+\s*', ' ', clean)
    # Remove annotations
    clean = re.sub(r'\s*\([^)]*co-correspond[^)]*\)', '', clean, flags=re.IGNORECASE)
    clean = re.sub(r'\s*\(I am one[^)]*\)', '', clean, flags=re.IGNORECASE)
    # Normalize whitespace
    clean = re.sub(r'\s+', ' ', clean).strip(". ")

    # Strategy 1: Look for (YYYY) pattern that separates authors from title
    year_match = re.search(r'\((?:19|20)\d{2}\)\s*\.?\s*', clean)
    if year_match and year_match.start() < len(clean) * 0.8:
        authors = clean[:year_match.start()].strip(" ,.")
        rest = clean[year_match.end():].strip(" .")
        parts = [p.strip() for p in rest.split(". ") if p.strip()]
        if len(parts) >= 2:
            title = parts[0]
            journal = _clean_journal(parts[1])
        elif len(parts) == 1:
            # Try comma split
            comma_parts = parts[0].rsplit(", ", 1)
            if len(comma_parts) == 2 and not comma_parts[1][0].islower():
                title = comma_parts[0]
                journal = _clean_journal(comma_parts[1])
            else:
                title = parts[0]
    else:
        # Strategy 2: Standard "Authors. Title. Journal." format
        parts = [p.strip() for p in clean.split(". ") if p.strip()]
        if len(parts) >= 3:
            authors = parts[0]
            title = parts[1]
            journal = _clean_journal(parts[2])
        elif len(parts) == 2:
            authors = parts[0]
            title = parts[1]
        elif len(parts) == 1:
            title = parts[0]

    # Clean up
    title = re.sub(r'^\(\d{4}\)\s*', '', title)
    title = title.strip(" .,;:")

    return title, authors, journal


# ---------------------------------------------------------------------------
# Write Jekyll post
# ---------------------------------------------------------------------------

POST_TEMPLATE = """---
layout: page
title: "{title}"
breadcrumb: true
categories:
    - publication
pub:
    authors: "{authors}"
    journal: "{journal}"
    date: {year}
    doi: {doi}
---
"""


def write_post(outdir, title, authors, journal, year, month, day, doi):
    slug = slugify(title)
    if not slug:
        slug = slugify(doi.replace("/", "_").replace(".", "_"))
    date_str = f"{int(year):04d}-{int(month):02d}-{int(day):02d}"
    filename = f"{date_str}-{slug}.md"
    filepath = os.path.join(outdir, filename)

    # Avoid overwriting: append a counter if file already exists
    counter = 2
    while os.path.exists(filepath):
        filename = f"{date_str}-{slug}_{counter}.md"
        filepath = os.path.join(outdir, filename)
        counter += 1

    # Escape quotes in YAML strings
    safe_title = title.replace('"', '\\"')
    safe_authors = authors.replace('"', '\\"')
    safe_journal = journal.replace('"', '\\"')

    content = POST_TEMPLATE.format(
        title=safe_title,
        authors=safe_authors,
        journal=safe_journal,
        year=int(year),
        doi=doi,
    )

    with open(filepath, "w") as f:
        f.write(content)
    return filepath


# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------

def process_entry(year_str, text, outdir, dry_run=False, log_file=None):
    """Process a single citation entry. Returns info dict."""
    doi = extract_doi(text)
    fallback_year = int(year_str) if year_str else 2000
    source = ""

    # Always extract the preferred author list from the HTML citation text
    preferred_authors = extract_authors_from_citation(text)

    title, cr_authors, journal = "", "", ""
    year, month, day = fallback_year, 1, 1
    cr_title = ""
    crossref_matched = False

    # Step 1: Try CrossRef by DOI
    if doi and not dry_run:
        msg = fetch_crossref(doi)
        if msg:
            cr_title, cr_authors, journal, cr_year, month, day = metadata_from_crossref(msg)
            # Validate that the CrossRef result matches the original citation
            if validate_crossref_match(cr_title, text):
                title = cr_title
                year = cr_year or fallback_year
                source = "crossref-doi"
                crossref_matched = True
            else:
                source = "crossref-doi-REJECTED"

    # Step 2: Fall back to text parsing
    if not crossref_matched:
        parsed_title, parsed_authors, parsed_journal = parse_citation_text(text, fallback_year)
        title = parsed_title
        journal = parsed_journal
        year, month, day = fallback_year, 1, 1
        if not doi:
            doi = "NA"
        if not source:
            source = "text-parse"
        else:
            source += "+text-parse"

    # Always use the preferred (HTML) author list
    authors = preferred_authors

    if not doi:
        doi = "NA"

    if not title:
        title = text[:100]

    info = {
        "input": text,
        "source": source,
        "doi": doi,
        "title": title,
        "preferred_authors": preferred_authors,
        "crossref_authors": cr_authors,
        "crossref_title": cr_title,
        "crossref_matched": crossref_matched,
        "authors": authors,
        "journal": journal,
        "year": year,
    }

    if not dry_run:
        fp = write_post(outdir, title, authors, journal, year, month, day, doi)
        info["file"] = os.path.basename(fp)

    return info


def _has_bing_ren(authors):
    """Check if the author string contains any variant of Bing Ren's name."""
    patterns = ["Bing Ren", "Ren B", "B Ren", "B. Ren", "Ren, B"]
    lower = authors.lower()
    for p in patterns:
        if p.lower() in lower:
            return True
    return False


def main():
    import argparse
    parser = argparse.ArgumentParser(description="Convert HTML or text publication list to Jekyll posts")
    parser.add_argument("input_file", help="Input file (HTML or tab-separated text)")
    parser.add_argument("--dry-run", action="store_true",
                        help="Parse and log results without writing files or calling CrossRef")
    parser.add_argument("--log", default=None,
                        help="Write detailed comparison log to this file")
    args = parser.parse_args()

    with open(args.input_file) as f:
        content = f.read()

    fmt = detect_format(content)
    if fmt == "html":
        entries = parse_html(content)
        print(f"Parsed {len(entries)} entries from HTML")
    else:
        entries = parse_text(content)
        print(f"Parsed {len(entries)} entries from text")

    # Determine output directory
    script_dir = os.path.dirname(os.path.abspath(__file__))
    repo_root = os.path.dirname(script_dir)
    outdir = os.path.join(repo_root, "_posts", "publications")

    if not args.dry_run:
        # Clear existing posts
        if os.path.isdir(outdir):
            for fn in os.listdir(outdir):
                if fn.endswith(".md"):
                    os.remove(os.path.join(outdir, fn))
            print(f"Cleared existing posts in {outdir}")
        else:
            os.makedirs(outdir, exist_ok=True)

    # Open log file if requested
    log_fh = None
    if args.log:
        log_fh = open(args.log, "w")
        log_fh.write("# Publication Conversion Log\n\n")
        log_fh.write(f"Input: {args.input_file} (format: {fmt})\n")
        log_fh.write(f"Total entries: {len(entries)}\n\n")
        log_fh.write("=" * 80 + "\n\n")

    written = 0
    warnings = []
    for i, (year_str, text) in enumerate(entries, 1):
        info = process_entry(year_str, text, outdir, dry_run=args.dry_run, log_file=log_fh)

        # Check for Bing Ren in authors
        has_ren = _has_bing_ren(info['preferred_authors'])
        if not has_ren:
            warnings.append((i, info))

        # Console output
        print(f"\n--- Entry {i} (year: {year_str}) ---")
        print(f"  SOURCE:           {info['source']}")
        print(f"  DOI:              {info['doi']}")
        print(f"  TITLE:            {info['title'][:100]}")
        print(f"  PREFERRED AUTH:   {info['preferred_authors'][:100]}...")
        if info['crossref_authors']:
            print(f"  CROSSREF AUTH:    {info['crossref_authors'][:100]}...")
        if not info['crossref_matched'] and info['crossref_title']:
            print(f"  CROSSREF TITLE:   {info['crossref_title'][:100]} [REJECTED]")
        print(f"  JOURNAL:          {info['journal']}")
        print(f"  YEAR:             {info['year']}")
        if not has_ren:
            print(f"  *** WARNING: No 'Bing Ren' variant found in authors! ***")
        if 'file' in info:
            print(f"  FILE:             {info['file']}")

        # Log file output
        if log_fh:
            log_fh.write(f"## Entry {i} — Year: {year_str}\n\n")
            log_fh.write(f"### Original Record\n")
            log_fh.write(f"```\n{info['input']}\n```\n\n")
            log_fh.write(f"### Preferred Author List\n")
            log_fh.write(f"```\n{info['preferred_authors']}\n```\n\n")
            log_fh.write(f"### CrossRef Query Result\n")
            log_fh.write(f"- DOI queried: `{info['doi']}`\n")
            log_fh.write(f"- CrossRef title: `{info['crossref_title']}`\n")
            log_fh.write(f"- CrossRef authors: `{info['crossref_authors']}`\n")
            log_fh.write(f"- Match validated: **{info['crossref_matched']}**\n")
            log_fh.write(f"- Source used: `{info['source']}`\n\n")
            log_fh.write(f"### Final Output\n")
            log_fh.write(f"- Title: `{info['title']}`\n")
            log_fh.write(f"- Authors: `{info['authors']}`\n")
            log_fh.write(f"- Journal: `{info['journal']}`\n")
            log_fh.write(f"- Year: `{info['year']}`\n")
            log_fh.write(f"- Has Bing Ren: **{has_ren}**\n")
            if 'file' in info:
                log_fh.write(f"- File: `{info['file']}`\n")
            log_fh.write(f"\n{'=' * 80}\n\n")

        written += 1

        if not args.dry_run:
            time.sleep(0.3)

    # Summary
    print(f"\n{'=' * 60}")
    print(f"Done: {written} entries processed")

    if warnings:
        print(f"\n*** WARNING: {len(warnings)} entries do NOT have Bing Ren as author: ***")
        for idx, info in warnings:
            print(f"  Entry {idx}: {info['title'][:80]}")
            print(f"    Authors: {info['preferred_authors'][:100]}")

    if log_fh:
        log_fh.write(f"\n# Summary\n\n")
        log_fh.write(f"Total entries: {written}\n")
        log_fh.write(f"Entries without Bing Ren: {len(warnings)}\n\n")
        if warnings:
            log_fh.write(f"## Entries Missing Bing Ren\n\n")
            for idx, info in warnings:
                log_fh.write(f"- Entry {idx}: `{info['title'][:80]}`\n")
                log_fh.write(f"  - Authors: `{info['preferred_authors'][:100]}`\n")
        log_fh.close()
        print(f"\nLog written to: {args.log}")


if __name__ == "__main__":
    main()
