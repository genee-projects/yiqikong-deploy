#!/bin/bash

update-docker-dnsmasq > /dev/null

docker run \
    -P \
    -d \
    -v /dev/log:/dev/log \
    -v "$workdir/gini-modules/":/data/gini-modules/ \
    --dns 172.17.42.1 \
    --restart always \
    --hostname yiqikong-user \
    --name yiqikong-user \
    genee/gini:latest

docker exec yiqikong-user bash -c '
    . /etc/profile
    export GINI_ENV="testing"
    cd /data/gini-modules/yiqikong-user
    gini composer init -n
    composer update --prefer-dist
    gini install
    gini cache
    gini web update
'
