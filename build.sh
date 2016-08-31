#!/usr/bin/env bash

POSTGRES_VERSION="$1"
CCDB_VERSION="$2"
CCDB_WS_TARGET_WAR="$3"
CCDB_CORE_TARGET_WAR="$4"
CCDB_DOCKER_IMAGE_NAME="$5"

# Copy files to correct locations, removing existing "wars" and "jars"
rm -f deploy/*.war
rm -f deploy/*.jar
cp ${CCDB_CORE_TARGET_WAR} deploy/
cp ${CCDB_WS_TARGET_WAR} deploy/
cp postgresql-${POSTGRES_VERSION}.jar deploy/

# Change this if your Host have a "sane" DNS like 168.192.1.1
OPTNAMESERVER="echo nameserver 10.0.0.71 > /etc/resolv.conf \&\& \\\\"
#OPTNAMESERVER="\\\\"

sed -e "s|OPTNAMESERVER|${OPTNAMESERVER}|g" \
    -e "s|ENV_POSTGRES_VERSION|${POSTGRES_VERSION}|g" \
    -e "s|ENV_CCDB_VERSION|${CCDB_VERSION}|g" \
    Dockerfile.ini > Dockerfile

docker build -t lerwys/docker-${CCDB_DOCKER_IMAGE_NAME}-wildfly .
