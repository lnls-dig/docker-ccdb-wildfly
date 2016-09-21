#!/usr/bin/env bash

set -a
set -u
set -e

# Source env vars
. ./env-vars.sh

# Copy files to correct locations
cp ${CCDB_CORE_TARGET_WAR} /deploy
cp ${CCDB_WS_TARGET_WAR} /deploy
cp postgresql-${POSTGRES_VERSION}.jar /deploy
