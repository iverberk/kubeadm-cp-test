#!/bin/sh
SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
docker rm -f k8s-api &> /dev/null
docker run -d --name k8s-api -it -v $SCRIPTPATH/config:/usr/local/etc/haproxy:ro -p 9000:9000 -p 0.0.0.0:6443:6443 haproxy:1.8.14
