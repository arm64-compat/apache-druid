#!/bin/bash -x

source ./set-env.sh $1

docker push ${DOCKER_IMAGE}
