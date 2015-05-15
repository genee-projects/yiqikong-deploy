#!/bin/bash

update-docker-dnsmasq > /dev/null

docker run \
    -P \
    -d \
    -p 4219:80 \
    -p 80:80 \
    -v /home/genee/yiqikong/data/etc/nginx/sites-enabled/:/etc/nginx/sites-enabled/ \
    -v /home/genee/yiqikong/data/var/log/nginx:/var/log/nginx \
    -v /home/genee/yiqikong/data/gini-modules:/data/gini-modules \
    --dns 172.17.42.1 \
    --restart always \
    --hostname nginx \
    --name nginx \
    genee/nginx:latest
