#!/bin/bash

current_dir=$(pwd)
docker_dirs=$(ls -d $(pwd)/*/)

for d in ${docker_dirs[@]}
do
    cd "$d"
    if [ -d "./_k8s" ]; then
        cd _k8s
        if [ -f "./kubectl.sh" ]; then
            ./kubectl.sh
        fi
    fi
    cd "$current_dir"
done
