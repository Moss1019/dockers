#!/bin/bash

current_dir=$(pwd)
docker_dirs=$(ls -d $(pwd)/*/)

for d in ${docker_dirs[@]}
do
    cd "$d"
    if [ -f "./buildk8s.sh" ]; then
        permission=$(stat -c %a ./buildk8s.sh)
        if [ "$permission" -lt 755 ]; then
            chmod +x ./buildk8s.sh
        fi
        if [ -f "Dockerfile" ]; then
            ./buildk8s.sh
        fi
    fi
    cd "$current_dir"
done
