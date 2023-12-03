#! /usr/bin/env python

fname = "exported_items.bib"

class Article:
  def init(self):
    return
  # title
  # author
  # journal
  # date 
  # doi
  # volume
  # pages 
  # number
  # abstract

with open(fname, 'r') as infile:
  num = 0
  for line in infile:
    if line.startswith("@article"):
      article = Article()
      article.name = line.strip().split("{")[1].replace(",","")
      num += 1
    if line.strip().startswith("title"):
      article.title = line.strip().replace("{","").replace("}","").split('=')[1].replace(",","").replace("\\","")
    elif line.strip().startswith("author"):
      authors = line.strip().split("=")[1].replace("{","").replace("}","").split(" and ")
      authors = [  " ".join(au.strip().split(",")[::-1]) for au in authors]
      article.author = ','.join(authors)
    elif line.strip().startswith("journaltitle"):
          article.journal = line.strip().split("=")[1].replace("{","").replace("}","").replace(",","").replace("\\","")
    elif line.strip().startswith("date"):
      article.date = line.strip().split("=")[1].replace("{","").replace("}","").replace(",","").strip()
    elif line.strip().startswith("doi"):
      article.doi = line.strip().split("=")[1].replace("{","").replace("}","").replace(",","")
    elif line.strip().startswith("volume"):
      article.volume = line.strip().split("=")[1].replace("{","").replace("}","").replace(",","")
    elif line.strip().startswith("pages"):
      article.pages = line.strip().split("=")[1].replace("{","").replace("}","").replace(",","")
    elif line.strip().startswith("number"):
      article.number = line.strip().split("=")[1].replace("{","").replace("}","").replace(",","")
    elif line.strip().startswith("abstract"):
      article.abstract = line.strip().split("=")[1].replace("{","").replace("}","").replace("\\","").replace('"',"")
      
      
    if line.startswith("}"):
       if article.date.count('-')==0:
         out_file_name = article.date+"-01-01-"+ article.name + ".md"
       elif article.date.count('-')==1:
         out_file_name = article.date+"-01-"+ article.name + ".md"
       elif article.date.count('-')==2:
         out_file_name = article.date+"-"+ article.name + ".md"
       else: 
          print("error")
          print(article.date)
          exit(1)
       out = []
       out.append("---")
       out.append("layout: page")
       out.append("title: "+'"'+ article.title +'"')
       out.append("breadcrumb: true")
       out.append("categories:")
       out.append("    - publication")
       out.append("## publication related information") 
       out.append("pub:")
       out.append("    authors: "+ '"'+article.author+'"')
       out.append("    journal: "+ '"'+article.journal + '"')
       out.append("    date: " + article.date)
       if hasattr(article,"doi"):
         out.append("    doi: " + article.doi)
       if hasattr(article,"volume"):
         out.append("    volume: "+ article.volume)
       if hasattr(article,"pages"):
         out.append("    pages: " + article.pages)
       if hasattr(article,"number"):
         out.append("    number: " + article.number)
       if hasattr(article, "abstract"):
         out.append("    abstract: "+ '"'+ article.abstract +'"')
       out.append("---")
       with open(out_file_name,'w') as fout:
         fout.write("\n".join(out))
#      print(article.title)
#      print(article.author)
#      print(article.date)
#      print(article.doi)
#      print(article.volume)
#      print(article.pages)
#      print(article.number)
#      print(article.abstract)



