#!/bin/bash

DIR=$(dirname $0)

cat $DIR/sphinx.conf

for FILE in `ls $DIR/conf.d/*.conf`
do
        cat $FILE
done
