# renlab-website
style cheatsheet: https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet
## Please keep adding new instructions to the website. 
 * The URL of the lab website is: renlab.sdsc.edu

## Instructions
## To update the content on the website.
  1. `ssh renlab.sdsc.edu` (only the admin can do this).
  2. `cd /var/www/html/renlab-website-git/
  3. Make changes to the files. And then run `bash build_site.sh`.

### Lab member page
To add or change current and past lab members, go to `_data/labmembers.md` or  `_data/alumni.md`. 

### Publication page
To add or change publications, download record from NCBI Pubmed, and format it using the Python script in th `_post/publication` folder,

### News page
To add or change news, go to `_posts/news/`, and add an markdown file using the templates from previous markdown files. 

### Images
You can add new images to the `image` directory, and use them for the news/posts. 

### For other advanced functionalities, please checkout the [Feeling-responsive](https://phlow.github.io/feeling-responsive/) templates. 
