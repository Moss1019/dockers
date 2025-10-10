#!/bin/bash

current_dir=$(pwd)
docker_dirs=$(ls -d $(pwd)/*/)

for d in ${docker_dirs[@]}
do
    cd "$d"
    if [ -d "./_k8s" ]; then
        cd _k8s
        if [ -f "./service.yaml" ]; then
            kubectl apply -f "service.yaml"
        fi
        if [ -f "replica-set.yaml" ]; then
            kubectl apply -f ""replica-set.yaml""
        fi
    fi
    cd "$current_dir"
done
