#!/bin/bash

update-docker-dnsmasq > /dev/null

mysql -h yiqikong-mysql.docker.local -ugenee -p83719730 -e "CREATE DATABASE IF NOT EXISTS yiqikong_billing"

docker run \
    -P \
    -d \
    -v /dev/log:/dev/log \
    -v "$workdir/gini-modules/":/data/gini-modules/ \
    --dns 172.17.42.1 \
    --restart always \
    --hostname yiqikong-billing \
    --name yiqikong-billing \
    genee/gini:latest

docker exec yiqikong-billing bash -c '
    . /etc/profile
    export GINI_ENV="testing"
    cd /data/gini-modules/yiqikong-billing
    gini composer init -n
    composer update --prefer-dist
    gini install
    gini cache
    gini orm update
    gini web update
'
