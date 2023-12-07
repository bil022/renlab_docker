build:
	docker build -t bil022/renlab_website .
run:
	docker run -it -v /Users/bli/src/renlab_mini:/site bil022/renlab_website
debug:
	docker run -it -v /Users/bli/src/renlab_mini:/site --entrypoint="/bin/bash" bil022/renlab_website
	#docker run -p 4000:4000 -v /Users/bli/src/renlab_mini:/site renlab_website
	#docker run -e "YML=renlab" -p 4000:4000 -v /Users/bli/src/renlab:/site renlab_website
