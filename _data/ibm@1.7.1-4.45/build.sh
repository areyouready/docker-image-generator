#!/bin/bash
function docker_tag_exists() {
    EXISTS=$(curl -s  https://hub.docker.com/v2/repositories/$1/tags/?page_size=10000 | jq -r "[.results | .[] | .name == \"$2\"] | any")
    test $EXISTS = true
}

if docker_tag_exists svenruppert/ibm 1.7.1-4.45; then
    echo skip building, image already existing
else
    echo start building the images
    docker build -t svenruppert/ibm .

    docker tag svenruppert/ibm:latest svenruppert/ibm:1.7.1-4.45
    docker push svenruppert/ibm:1.7.1-4.45
fi