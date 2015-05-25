#!/bin/bash

docker run \
    -P \
    -d \
    -p 3306:3306 \
    -v "$workdir/var/lib/mysql":/data \
    --dns 172.17.42.1 \
    --restart always \
    --hostname yiqikong-mysql \
    --name yiqikong-mysql \
    genee/mariadb:latest
