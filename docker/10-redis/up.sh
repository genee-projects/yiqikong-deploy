#!/bin/bash

docker run \
    -P \
    -d \
    -p 6379:6379\
    --dns 172.17.42.1 \
    --restart always \
    --hostname redis \
    --name redis \
    redis:latest
