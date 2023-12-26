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
