renlab:
	./build_dev.sh
	rsync -Pav -e "ssh -i $$HOME/air/.ssh/id_rsa" _site_dev renlab.sdsc.edu:/var/www/html/renlab-website-git/.
all:
	bundle exec jekyll serve
build:
	bundle exec jekyll build
install:
	rm Gemfile.lock 
	bundle install
