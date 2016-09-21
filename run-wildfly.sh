#!/usr/bin/env bash

set -a
set -e
set -u

. ./env-vars.sh

# Run Wildfly
docker run --name ${CCDB_DOCKER_RUN_NAME} --net ${NET_NAME} --dns ${DNS_IP} \
    -p ${LOCAL_WILDFLY_PORT}:${WILDFLY_PORT} -p ${LOCAL_ADMIN_PORT}:${ADMIN_PORT} \
    -d --entrypoint "/wait-for-it.sh" ${CCDB_DOCKER_ORG_NAME}/${CCDB_DOCKER_IMAGE_NAME} \
    ${DB_NAME}:${DB_PORT} -- /opt/jboss/wildfly/bin/standalone.sh \
    -b 0.0.0.0 -bmanagement 0.0.0.0
