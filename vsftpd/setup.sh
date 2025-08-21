#!/bin/bash

rm ./container_key*
[ -f $HOME/.ssh/container_key ] && rm $HOME/.ssh/container_key

ssh-keygen -t rsa -b 1024 -f ./container_key

mv container_key $HOME/.ssh/container_key