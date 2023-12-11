dev:
	bundle exec jekyll build --config _config.yml,_config_renlab_dev.yml -d _site_dev
all:
	bundle exec jekyll build --config _config.yml,_config_renlab.yml -d _site
serve:
	bundle exec jekyll serve
