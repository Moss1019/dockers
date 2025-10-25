#!/bin/bash

if [ -z "${2}" ]; then
    echo "Container name required"
    exit 1
fi
if [ -z "${3}" ]; then
    echo "Container port required"
    options=$(kubectl get svc -n $1 | grep "$2" | awk '{print $5}')
    echo "Options are ${options}"
    exit 1
fi
if [ -z "${4}" ]; then
    echo "Host port required"
    exit 1
fi

container=$(kubectl get po -n $1 | grep "$2" | awk '{print $1}')

if [ -z "${container}" ]; then
    echo "No container found"
    exit 1
fi

kubectl port-forward $container -n $1 ${4}:${3}
