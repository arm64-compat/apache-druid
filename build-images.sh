#!/bin/bash -x

DOCKER_DIR=$1
shift

source ./set-env.sh $DOCKER_DIR

$MVN -f $DOCKER_DIR/pom.xml install $@

case $BUILD_ARCH in
    
    "amd64")
        BUILD_ARCH="x86_64"
        ;;

    "arm64")
        BUILD_ARCH="aarch64"
        ;;

esac

docker build \
	--build-arg DRUID_VERSION=${DRUID_VERSION} \
	--build-arg JDK_VERSION=${BUILD_ARCH}-debian-jre-11.0.18_10 \
	-t ${DOCKER_IMAGE} .
