all:
	[ -e _posts/publications ] || mkdir -p _posts/publications
	[ -e _posts/news ] || mkdir -p _posts/news
	[ -e images ] || mkdir -p images
	wget https://renlab.sdsc.edu/renlab_docker/uploader.php?ID -O .ID
	wget https://renlab.sdsc.edu/renlab_docker/uploader.php?publications -O _posts/publications/`cat .ID`.md
	wget https://renlab.sdsc.edu/renlab_docker/uploader.php?news -O _posts/news/`cat .ID`.md
	cp uploader.png images/`cat .ID`.png	
	rm -f .ID
