#!/bin/bash
function docker_tag_exists() {
    EXISTS=$(curl -s  https://hub.docker.com/v2/repositories/$1/tags/?page_size=10000 | jq -r "[.results | .[] | .name == \"$2\"] | any")
    test $EXISTS = true
}

if docker_tag_exists svenruppert/maven-3.6.1-zulu 1.7.154; then
    echo skip building, image already existing - svenruppert/maven-3.6.1-zulu 1.7.154
else
    echo start building the images
    docker build -t svenruppert/maven-3.6.1-zulu .
    docker tag svenruppert/maven-3.6.1-zulu:latest svenruppert/maven-3.6.1-zulu:1.7.154
    docker push svenruppert/maven-3.6.1-zulu:1.7.154
fi