#!/bin/bash

docker run \
    -P \
    -d \
    -p 9306 \
    -v /dev/log:/dev/log \
    -v "$workdir/etc/sphinxsearch":/etc/sphinxsearch \
    -v "$workdir/var/lib/sphinxsearch":/var/lib/sphinxsearch \
    --dns 172.17.42.1 \
    --restart always \
    --hostname yiqikong-sphinxsearch \
    --name yiqikong-sphinxsearch \
    genee/sphinxsearch:latest
