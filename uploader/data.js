const fs = require('fs');

const data = require('./data.json');
function get(key) {
  return data.filter(d=>d.name==key)[0].value;
}
fname=get('fname');
title=get('title');
authors=get('authors');
journal=get('journal');
doi=get('doi');
abstract_=get('abstract');
teaser=get('teaser');
full_text_link=get('full_text_link');
year = new Date().getFullYear();

const news = fs.readFileSync("news.md", "utf8");

console.log(news);

/*
console.log("---	
layout:	page
subheadline:	Congratulations!
title:	"${title}"
teaser: 	"${teaser}"
breadcrumb: true	
tags:	
    - paper accepted	
categories:	
    - news	
image:	
    thumb: 	${fname}.png
    title:	${fname}.png
    caption_url: 	http://unsplash.com
---	
	
<b>Abstract</b>:	
${abstract_}

> Full text can be accessed from the following [link](${full_text_line})

==> ../_posts/publications/${fname}.md <==
--	
layout:	page
title:	”${title}"
breadcrumb: true	
categories:	
- publication	
## publication related information	
pub:	
authors:	${authors}
	
journal:	"${journal}"
date:	2024
doi:	${doi}
abstract:	${abstract_}
--	
../images/${fname}.png
*/
