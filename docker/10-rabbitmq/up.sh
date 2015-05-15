#!/bin/bash

docker run \
    -P \
    -d \
    -p 5672:5672 \
    -p 15672:15672 \
    -v /home/genee/yiqikong/data/var/lib/rabbitmq:/var/lib/rabbitmq \
    --dns 172.17.42.1 \
    --restart always \
    --hostname yiqikong-rabbitmq \
    --name yiqikong-rabbitmq \
    genee/rabbitmq:latest
