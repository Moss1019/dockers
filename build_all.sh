#!/bin/bash

current_dir=$(pwd)
docker_dirs=$(ls -d $(pwd)/*/)

for d in ${docker_dirs[@]}
do
    cd "$d"
    if [ -f "./build.sh" ]; then
        permission=$(stat -c %a ./build.sh)
        if [ "$permission" -lt 755 ]; then
            chmod +x ./build.sh
        fi
        if [ -f "Dockerfile" ]; then
            ./build.sh
        fi
    fi
    cd "$current_dir"
done
