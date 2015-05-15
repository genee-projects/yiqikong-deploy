#!/bin/bash

update-docker-dnsmasq > /dev/null

docker run \
    -P \
    -d \
    -v /dev/log:/dev/log \
    -v /home/genee/yiqikong/data/gini-modules/:/data/gini-modules/ \
    --dns 172.17.42.1 \
    --restart always \
    --hostname yiqikong-reserve \
    --name yiqikong-reserve \
    genee/gini:latest
