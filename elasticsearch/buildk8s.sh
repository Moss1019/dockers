#! /bin/bash

docker build -t 192.168.50.149:5000/elasticsearch .
docker push 192.168.50.149:5000/elasticsearch
docker rmi 192.168.50.149:5000/elasticsearch

