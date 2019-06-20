#!/bin/bash
function docker_tag_exists() {
    EXISTS=$(curl -s  https://hub.docker.com/v2/repositories/$1/tags/?page_size=10000 | jq -r "[.results | .[] | .name == \"$2\"] | any")
    test $EXISTS = true
}

if docker_tag_exists svenruppert/openjdk-ri 1.7.75; then
    echo skip building, image already existing
else
    echo start building the images
    docker build -t svenruppert/openjdk-ri .

    docker tag svenruppert/openjdk-ri:latest svenruppert/openjdk-ri:1.7.75
    docker push svenruppert/openjdk-ri:1.7.75
fi