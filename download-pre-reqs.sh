#!/usr/bin/env bash

# Source env vars
. ./env-vars.sh

curl -o postgresql-${POSTGRES_VERSION}.jar https://jdbc.postgresql.org/download/postgresql-${POSTGRES_VERSION}.jar

# Clone ESS java config
git clone --branch=${ESS_JAVA_CONFIG_VERSION} https://bitbucket.org/europeanspallationsource/ess-java-config ${ESS_JAVA_CONFIG_REPO}
# Clone naming-convention-tool
git clone --branch=${CCDB_REPO_VERSION} https://bitbucket.org/europeanspallationsource/ccdb.git ${CCDB_REPO}
# Clone wait-for-it
git clone --branch=${WAIT_FOR_IT_VERSION} https://github.com/vishnubob/wait-for-it ${WAIT_FOR_IT_REPO}

# Build Java Config
cd ${ESS_JAVA_CONFIG_REPO}
mvn install
cd ..

# Apply patches
cd ${CCDB_REPO}
git am --ignore-whitespace /build/patches/ccdb/*
cd ..

# Build flyway
cd ${CCDB_REPO}/${CCDB_FLYWAY_DIR}
mvn flyway:migrate
cd ../../

# Build ccdb core and Web Service
cd ${CCDB_REPO}/${CCDB_CORE_DIR}
mvn clean && mvn install -P jboss,production -Dmaven.test.skip=true
cd ../../

cd ${CCDB_REPO}/${CCDB_WS_DIR}
mvn clean && mvn install -P jboss,production -Dmaven.test.skip=true
cd ../../
