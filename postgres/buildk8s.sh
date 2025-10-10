#! /bin/bash

docker build -t 192.168.50.149:5000/postgres .
docker push 192.168.50.149:5000/postgres
docker rmi 192.168.50.149:5000/postgres

