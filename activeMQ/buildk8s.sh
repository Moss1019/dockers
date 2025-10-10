#! /bin/bash

docker build -t 192.168.50.149:5000/activemq .
docker push 192.168.50.149:5000/activemq
docker rmi 192.168.50.149:5000/activemq
