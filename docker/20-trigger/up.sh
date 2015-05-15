#!/bin/bash

docker run \
    -P \
    -d \
    -v /home/genee/yiqikong/data/etc/debade:/etc/debade \
    --dns 172.17.42.1 \
    --restart always \
    --hostname debade-trigger \
    --name debade-trigger \
    genee/debade-trigger:latest
