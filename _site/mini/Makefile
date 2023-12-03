dev:
	./build_dev.sh
	# rsync -av _site_dev renlab.sdsc.edu:/var/www/html/renlab-website-git/.
web:
	bundle exec jekyll build --config _config.yml,_config_renlab.yml -d _site
	rsync -av _site renlab.sdsc.edu:/var/www/html/renlab-website-git/.
local:
	bundle exec jekyll build --config _local.yml -d _site_dev
	# bundle exec jekyll serve --config _local.yml -d _site_dev --port 8080
all:
	bundle exec jekyll serve
build:
	bundle exec jekyll build
install:
	rm Gemfile.lock 
	bundle install
dev0:
	cd ./docker/jekyll-serve && make dev
renlab:
	cd ./docker/jekyll-serve && make renlab
ren:
	bundle exec jekyll build --config _config.yml,_config_renlab.yml
