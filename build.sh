#!/usr/bin/env bash

. ./env-vars.sh

docker build -t ${CCDB_DOCKER_ORG_NAME}/${CCDB_DOCKER_IMAGE_NAME} .
