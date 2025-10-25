# dockers
External dependencies in docker containers to run them locally or in a K8S cluster.

These containers can be started with docker compose, some of them require the image to be built first, these are easy to spot: they have a dockerfile included.
There should be a build.sh script included to build it

There's also k8s yaml files to deploy the containers to a cluster. Running the kubectl.sh script will deploy an indicidual service, while kubectl_all.sh will deploy everything with config
