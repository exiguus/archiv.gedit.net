# Archiv gedit.net

Archives the current version of gedit.net.
And create a static site.

Test the static site by build and run a Docker image with nginx.

## Download current version

```bash
make fetch
```

## Create Docker image

```bash
make create
make build -B
make run
```

## Github Pages

Manual deploy to github pages:

```bash
git checkout gh-pages
make all
# test static site
make test
rm -rf ./docs/** && cp -r ./build/gedit.net/** docs/git
add docs/
git commit -m "feat(docs): update docs"
git push origin gh-pages
```

## test

test static site:

```bash
make test
```

update `url-list.txt` mock:

```bash
make all
wget --recursive --spider localhost:8080 2>&1 | grep '^--' | awk '{ print $3 }' | sort | uniq > url-list.txt
```
