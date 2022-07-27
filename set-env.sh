#!/bin/bash -x

export DOCKER_REGISTRY=${DOCKER_REGISTRY:=ghcr.io}
export DOCKER_REPOSITORY=${DOCKER_REPOSITORY:=arm64-compat}/apache/$1

BUILD_ARCH=$(uname -m)

case $BUILD_ARCH in
    
    "x86_64")
        BUILD_ARCH="amd64"
        ;;

    "aarch64")
        BUILD_ARCH="arm64"
        ;;

esac

export MVN="mvn -B"
export MVN_HELP="$MVN -q org.apache.maven.plugins:maven-help-plugin:3.2.0:evaluate -DforceStdout=true"
export DRUID_VERSION=$(sh -c "$MVN_HELP -f $1/pom.xml -Dexpression=project.version")
export DOCKER_TAG="$DRUID_VERSION-$BUILD_ARCH"
export MVN="$MVN -Pdist,bundle-contrib-exts"
export MVN="$MVN -Pskip-static-checks,skip-tests"
export MVN="$MVN -Dmaven.javadoc.skip=true"
export DOCKER_IMAGE=${DOCKER_REGISTRY}/${DOCKER_REPOSITORY}:${DOCKER_TAG}

echo "DRUID_VERSION=$CONFLUENT_VERSION"
echo "DOCKER_TAG=$DOCKER_TAG"

echo "MVN=$MVN"
