# stuffed-container
Various stuffed containers :)

## Build

``` bash
$ docker image build --rm -t ${TAGNAME} .
```

## Run

``` bash
$ docker container run -it --rm --hostname app001 --name app001 ${TAGNAME}
```
