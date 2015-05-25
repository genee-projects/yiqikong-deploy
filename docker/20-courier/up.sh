#!/bin/bash

docker run \
    -P \
    -d \
    -p 3333:3333 \
    -v "$workdir/etc/debade":/etc/debade \
    --dns 172.17.42.1 \
    --restart always \
    --hostname debade-courier \
    --name debade-courier \
    genee/debade-courier:latest
