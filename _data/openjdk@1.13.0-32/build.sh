#!/bin/bash
function docker_tag_exists() {
    EXISTS=$(curl -s  https://hub.docker.com/v2/repositories/$1/tags/?page_size=10000 | jq -r "[.results | .[] | .name == \"$2\"] | any")
    test $EXISTS = true
}

if docker_tag_exists svenruppert/openjdk 1.13.0-32; then
    echo skip building, image already existing - svenruppert/openjdk:1.13.0-32
else
    echo start building the images
    docker build -t svenruppert/openjdk .

    docker tag svenruppert/openjdk:latest svenruppert/openjdk:1.13.0-32
    docker push svenruppert/openjdk:1.13.0-32
fi