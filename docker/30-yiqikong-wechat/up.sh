#!/bin/bash

update-docker-dnsmasq > /dev/null

docker run \
    -P \
    -d \
    -v /dev/log:/dev/log \
    -v /home/genee/yiqikong/data/gini-modules/:/data/gini-modules/ \
    --dns 172.17.42.1 \
    --restart always \
    --hostname yiqikong-wechat \
    --name yiqikong-wechat \
    genee/gini:latest

docker exec yiqikong-wechat bash -c '
    . /etc/profile
    export GINI_ENV="testing"
    cd /data/gini-modules/yiqikong-wechat
    gini composer init -n
    composer update --prefer-dist
    gini install
    gini cache
    gini web update
'
