# stuffed-container
Various stuffed containers :)

## Build

``` bash
$ docker image build --rm -t ${TAGNAME} .
```

## Run

``` bash
$ docker container run -it --rm --hostname app001 --name app001 ${TAGNAME}

[root@app001]/home/app001# cat /etc/redhat-release
CentOS Linux release 8.0.1905 (Core)
[root@app001]/home/app001# uname -a
Linux app001 4.9.184-linuxkit #1 SMP Tue Jul 2 22:58:16 UTC 2019 x86_64 x86_64 x86_64 GNU/Linux
```
