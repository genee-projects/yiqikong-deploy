#!/bin/bash

update-docker-dnsmasq > /dev/null

mysql -h yiqikong-mysql.docker.local -ugenee -p83719730 -e "CREATE DATABASE IF NOT EXISTS yiqikong_sample"

docker run \
    -P \
    -d \
    -v /dev/log:/dev/log \
    -v /home/genee/yiqikong/data/gini-modules/:/data/gini-modules/ \
    --dns 172.17.42.1 \
    --restart always \
    --hostname yiqikong-sample \
    --name yiqikong-sample \
    genee/gini:latest

docker exec yiqikong-sample bash -c '
    . /etc/profile
    export GINI_ENV="testing"
    cd /data/gini-modules/yiqikong-sample
    gini composer init -n
    composer update --prefer-dist
    gini install
    gini cache
    gini orm update
    gini web update
'
