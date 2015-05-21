#!/bin/bash

update-docker-dnsmasq > /dev/null

mysql -h yiqikong-mysql.docker.local -ugenee -p83719730 -e "CREATE DATABASE IF NOT EXISTS yiqikong_reserve"

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

docker exec yiqikong-reserve bash -c '
    . /etc/profile
    export GINI_ENV="testing"
    cd /data/gini-modules/yiqikong-reserve
    gini composer init -n
    composer update --prefer-dist
    gini install
    gini cache
    gini orm update
    gini web update
'
