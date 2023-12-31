.PHONY: help

help:
	@echo "Please use \`make <target>' where <target> is one of"
	@echo "  create		to create output"
	@echo "  fetch		to fetch input (only run once to fetch input from gedit.net)"
	@echo "  build		to build docker image (run with -B to force rebuild)"
	@echo "  format		to format code"
	@echo "  test		to test docker image"
	@echo "  run		to run docker image"
	@echo "  all		to create output, build docker image and run docker image"


# Path: Makefile
# fetch input
fetch:
	cd ./input &&\
	wget --wait 1\
	  --recursive\
	  --page-requisites\
	  --convert-links\
	  --span-hosts\
	  --no-clobber\
	  --no-parent\
	  -e robots=off\
	  --no-check-certificate\
	  --keep-session-cookies\
	  --continue\
	  --accept-regex='/http:\/\/(img|dl|archiv|css)\.gedit.net/.*$||http:\/\/gedit.net/.*$/'\
	  -U='\''Mozilla/5.0 (compatible; gedit.NET/SCAN; de-DE; v.0.1)\'''\
	  --header 'Accept-encoding: identity'\
	  http://gedit.net/

# Path: Makefile
# create output
create:
	rm -rf ./output/*
	cp -R ./input/* ./output
# add css directory to gedit.net/
	mv ./output/css.gedit.net ./output/gedit.net/css
# add img directory to gedit.net/
	mv ./output/img.gedit.net ./output/gedit.net/img
# add dl directory to gedit.net/
	mv ./output/dl.gedit.net ./output/gedit.net/dl
# Replace all http://img.gedit.net/ with /img/
	find ./output -type f -exec sed -i 's/http:\/\/img\.gedit\.net\//\/img\//g' {} \;
# Replace all http://dl.gedit.net/ with /dl/
	find ./output -type f -exec sed -i 's/http:\/\/dl\.gedit\.net\//\/dl\//g' {} \;
# Replace all http://css.gedit.net/ with /css/
	find ./output -type f -exec sed -i 's/http:\/\/css\.gedit\.net\//\/css\//g' {} \;
# Replace all http://archiv.gedit.net/ with /archiv/
	find ./output -type f -exec sed -i 's/http:\/\/archiv\.gedit\.net\//\/archiv\//g' {} \;
# Replace all ../css.gedit.net/ with /css/
	find ./output -type f -exec sed -i 's/\.\.\/css\.gedit\.net\//\/css\//g' {} \;
# Replace all ../img.gedit.net/ with /img/
	find ./output -type f -exec sed -i 's/\.\.\/img\.gedit\.net\//\/img\//g' {} \;
# Replace all ../dl.gedit.net/ with /dl/
	find ./output -type f -exec sed -i 's/\.\.\/dl\.gedit\.net\//\/dl\//g' {} \;
# Replace all ../archiv.gedit.net/ with /archiv/
	find ./output -type f -exec sed -i 's/\.\.\/archiv\.gedit\.net\//\/archiv\//g' {} \;
# Replace all http://gedit.net/ with /
	find ./output -type f -exec sed -i 's/http:\/\/gedit\.net\//\//g' {} \;

# Remove &gzip=true or ?gzip=true from file name endings
	find ./output -type f -exec sh -c 'new_name=$$(echo "$$1" | sed -E "s/(\?|&)gzip=true//g"); mv "$$1" "$$new_name"; echo "Renamed $$1 to $$new_name";' sh {} \;

# Remove &gzip=true or ?gzip=true css file links in files
	find ./output -type f -exec sed -i -E 's/(\?|&amp;)gzip=true//g' {} \;

# Rename files that end with .css.php?ctg=[0-9] with .[0-9].css
	find ./output -type f -name '*.css.php?ctg=[0-9]' -exec sh -c 'new_name=$$(echo "$$1" | sed -E "s/\.css\.php\?ctg=([0-9])$$/.\\1.css/"); mv "$$1" "$$new_name"; echo "Renamed $$1 to $$new_name";' sh {} \;

# Rename files that end with .css.php with .css
	find ./output -type f -name '*.css.php' -exec sh -c 'new_name=$$(echo "$$1" | sed -E "s/\.css\.php$$/.css/"); mv "$$1" "$$new_name"; echo "Renamed $$1 to $$new_name";' sh {} \;

# Replace css file link in files with .css.php with .css
	find ./output -type f -exec sed -i 's/\.css\.php/.css/g' {} \;

# Replace style.css?ctg=[0-9] with style.[0-9].css from css file links in files
	find ./output -type f -exec sed -i -E 's/style\.css\?ctg=([0-9]+)/style.\1.css/g' {} \;

# Fix ";" and "," in filenames and hrefs
# Replace ";" in filesnames with "_"
	find ./output -type f -exec sh -c 'new_name=$$(echo "$$1" | sed -E "s/;/_/g"); mv "$$1" "$$new_name"; echo "Renamed $$1 to $$new_name";' sh {} \;
# Replace "," in filenames with "_"
	find ./output -type f -exec sh -c 'new_name=$$(echo "$$1" | sed -E "s/,/_/g"); mv "$$1" "$$new_name"; echo "Renamed $$1 to $$new_name";' sh {} \;
# Replace in all files ";" and "," in hrefs with "_"
	find ./output -type f -exec sed -i -E 's/href="(.*);(.*)"/href\=\"\1_\2"/g' {} \;
	find ./output -type f -exec sed -i -E 's/href="(.*),(.*)"/href\=\"\1_\2"/g' {} \;
	find ./output -type f -exec sed -i -E 's/href="(.*);(.*)"/href\=\"\1_\2"/g' {} \;
	find ./output -type f -exec sed -i -E 's/href="(.*),(.*)"/href\=\"\1_\2"/g' {} \;
	find ./output -type f -exec sed -i -E 's/href="(.*);(.*)"/href\=\"\1_\2"/g' {} \;
	find ./output -type f -exec sed -i -E 's/href="(.*),(.*)"/href\=\"\1_\2"/g' {} \;
# Replace in all files "%3B" and "%2C" in hrefs with "_"
	find ./output -type f -exec sed -i -E 's/href="(.*)%3B(.*)"/href\=\"\1_\2"/g' {} \;
	find ./output -type f -exec sed -i -E 's/href="(.*)%2C(.*)"/href\=\"\1_\2"/g' {} \;
	find ./output -type f -exec sed -i -E 's/href="(.*)%3B(.*)"/href\=\"\1_\2"/g' {} \;
	find ./output -type f -exec sed -i -E 's/href="(.*)%2C(.*)"/href\=\"\1_\2"/g' {} \;
# Fix druckvorschau
# Replace druckvorschau with Druckvorschau in filenames
	find ./output/gedit.net/* -type f -exec sh -c 'new_name=$$(echo "$$1" | sed -E "s/druckvorschau/Druckvorschau/g"); mv "$$1" "$$new_name"; echo "Renamed $$1 to $$new_name";' sh {} \;
# Remove files with Druckvorschau_Druckvorschau at the end
	find ./output -type f -name '*Druckvorschau_Druckvorschau' -exec rm {} \;
# Replace druckvorschau with Druckvorschau in files
	find ./output -type f -exec sed -i -E 's/druckvorschau/Druckvorschau/g' {} \;
# Replace _Druckvorschau_Druckvorschau in files with _Druckvorschau
	find ./output -type f -exec sed -i -E 's/_Druckvorschau_Druckvorschau/_Druckvorschau/g' {} \;
# Remove Artikle,druckvorschau folder
	rm -rf ./output/gedit.net/Artikel,druckvorschau
# Fix article
# Replace in dl/gedit.net style
	find ./output -type f -exec sed -i -E 's/dl\/css\.gedit\.net/css/g' {} \;
# Replace in css/img.gedit.net
	find ./output -type f -exec sed -i -E 's/css\/img\.gedit\.net/img/g' {} \;
# Replace www.gedit.net with gedit.net
	find ./output -type f -exec sed -i -E 's/www\.gedit\.net/gedit.net/g' {} \;
# Replace /css//img/gedit.net/ to /img/gedit.net/
	find ./output -type f -exec sed -i -E 's/\/css\/\/img\/gedit\.net\//\/img\/gedit\.net\//g' {} \;
#
# Extract templates from dl/gedit.net
	cp output/gedit.net/dl/gedit.net/static/templates/helvetica/helvetica-v0.1.zip output/gedit.net/dl/gedit.net/static/templates/helvetica/v0.1/
	cd output/gedit.net/dl/gedit.net/static/templates/helvetica/v0.1 && unzip -o helvetica-v0.1.zip
	cd output/gedit.net/dl/gedit.net/static/templates/vicard/ && unzip -o viCard-v0.4.zip
# rename to html file
	find ./output/gedit.net -type f ! -name '*.*' -exec sh -c 'for file; do mv "$$file" "$$file.html"; echo "Added .html extension to $$file"; done' sh {} \;
# rename VERSION files to html file
	find ./output/gedit.net -type f -name 'VERSION*' -exec sh -c 'for file; do mv "$$file" "$$file.html"; echo "Added .html extension to $$file"; done' sh {} \;
# add .html to all links if link href has no file extension
	find ./output/gedit.net/* -type f -exec sed -i -E 's/href="([^"\.]*)"/href="\1.html"/g' {} \;
# add .html to all links if link href contain VERSION
	find ./output/gedit.net/* -type f -exec sed -i -E 's/href="([^"]*VERSION[^"]*)"/href="\1.html"/g' {} \;
# fix links that end with # hash
	find ./output/gedit.net/* -type f -exec sed -i -E 's/href="([^"]*)(#[^"]*)\.html"/href="\1.html\2"/g' {} \;
# fix links that start with javascript
	find ./output/gedit.net/* -type f -exec sed -i -E 's/href="javascript:([^"]*).html"/href="\1"/g' {} \;
# fix links that start with .html
	find ./output/gedit.net/* -type f -exec sed -i -E 's/href="\.html([^"]*)"/href="\1"/g' {} \;
# remove ip addresses from who am i service Services_WhoAmI.html
	find ./output/gedit.net/* -type f -name 'Services_WhoAmI.html' -exec sed -i -E 's/([0-9]{1,3}\.){3}[0-9]{1,3}/0.0.0.0/g' {} \;
# remove hostname from who am i service Services_WhoAmI.html
	find ./output/gedit.net/* -type f -name 'Services_WhoAmI.html' -exec sed -i -E 's/<p class=\"right whoami\">[a-zA-Z0-9-]+\.[a-zA-Z0-9-]+\.[a-zA-Z-]{2,3}<\/p>/<p class=\"right whoami\">unknown<\/p>/g' {} \;
# fix missing <head> tags in .html files
	find ./output/gedit.net/* -type f -name '*.html' -exec sed -i -E 's/<html dir="ltr" lang="de">/<html dir="ltr" lang="de"><head>/g' {} +
# rename files that end with RSS.html to RSS.xml
	find ./output/gedit.net/* -type f -name '*RSS.html' -exec sh -c 'new_name=$$(echo "$$1" | sed -E "s/RSS.html/RSS.xml/"); mv "$$1" "$$new_name"; echo "Renamed $$1 to $$new_name";' sh {} \;
# change hrefs that end with RSS.html to RSS.xml
	find ./output/gedit.net/* -type f -exec sed -i -E 's/href="([^"]*)RSS.html"/href="\1RSS.xml"/g' {} \;

# additions
# cp addition/js into output/gedit.net/js
	cp -R ./addition/js ./output/gedit.net
# add script
	find ./output/gedit.net/* -type f -name '*.html' -exec sed -i -E 's/<\/body>/<script src="js\/archiv.js"><\/script><\/body>/g' {} \;

# Path: Makefile
# build docker
build:
	rm -rf ./build/*
	cp -R ./output/* ./build
# create docker image
	docker build --no-cache -t archiv.gedit.net .

# Path: Makefile
# run docker image
run:
	docker run -p 8080:80 archiv.gedit.net

# Path: Makefile
# format code
format:
	prettier --write . --ignore-path .prettierignore --config .prettierrc

# Path: Makefile
# test docker image
test:
	output_file="tmp-url-list.txt"; \
	wget --recursive --spider localhost:8080 2>&1 | grep '^--' | awk '{ print $$3 }' | sort | uniq > "$$output_file";\
	expected_file="url-list.txt"; \
	if diff "$$output_file" "$$expected_file"; then \
	    echo "Test passed: Output matches expected content."; \
			rm tmp-url-list.txt; \
			exit 0; \
	else \
	    echo "Test failed: Output does not match expected content."; \
			exit 1; \
	fi; \
	prettier --check . --ignore-path .prettierignore --config .prettierrc

# Path: Makefile
# run all
all:
	make create
	make format
	make build -B
	make run
