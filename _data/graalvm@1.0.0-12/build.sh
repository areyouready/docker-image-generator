#!/bin/bash
function docker_tag_exists() {
    EXISTS=$(curl -s  https://hub.docker.com/v2/repositories/$1/tags/?page_size=10000 | jq -r "[.results | .[] | .name == \"$2\"] | any")
    test $EXISTS = true
}

if docker_tag_exists svenruppert/graalvm 1.0.0-12; then
    echo skip building, image already existing - svenruppert/graalvm:1.0.0-12
else
    echo start building the images
    docker build -t svenruppert/graalvm .

    docker tag svenruppert/graalvm:latest svenruppert/graalvm:1.0.0-12
    docker push svenruppert/graalvm:1.0.0-12
fi