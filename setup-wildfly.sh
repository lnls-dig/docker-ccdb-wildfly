#!/usr/bin/env bash

set -a
set -e
set -u

# Source env vars
. ./env-vars.sh

# Download prereqs
./download-pre-reqs.sh

# Deploy app
./deploy-app.sh
