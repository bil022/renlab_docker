build:
	docker build -t renlab_website:latest .
renlab:
	docker run -e "YML=renlab.yml" -p 4000:4000 -v /Users/bli/src/renlab:/site renlab_website
dev:
	docker run -e "YML=dev.yml" -p 4000:4000 -v /Users/bli/src/renlab:/site renlab_website
