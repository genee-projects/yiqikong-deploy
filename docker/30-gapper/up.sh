#!/bin/bash

update-docker-dnsmasq > /dev/null

mysql -h yiqikong-mysql.docker.local -ugenee -p83719730 -e "CREATE DATABASE IF NOT EXISTS gapper"

docker run \
    -P \
    -d \
    -v /dev/log:/dev/log \
    -v /home/genee/yiqikong/data/gini-modules/:/data/gini-modules/ \
    --dns 172.17.42.1 \
    --restart always \
    --hostname yiqikong-gapper \
    --name yiqikong-gapper \
    genee/gini:latest

docker exec yiqikong-gapper bash -c '
    . /etc/profile
    export GINI_ENV="testing"
    cd /data/gini-modules/gapper-server
    gini composer init -n
    composer update --prefer-dist
    gini install
    gini cache
    gini orm update
    gini web update
'

mysql -h yiqikong-mysql.docker.local -ugenee -p83719730 -e "USE gapper; INSERT INTO \`app\` VALUES ('testing','testing','testing','http://yiqikong-gapper.wine.genee.cn','http://yiqikong-gapper.wine.genee.cn/assets/icon/gapper.png','',0,'client_id','client_secret',1,'{}');"
