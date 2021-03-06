#!/bin/sh

################################################################################
# This program and the accompanying materials are made available under the terms of the
# Eclipse Public License v2.0 which accompanies this distribution, and is available at
# https://www.eclipse.org/legal/epl-v20.html
#
# SPDX-License-Identifier: EPL-2.0
#
# Copyright IBM Corporation 2018, 2019
################################################################################

################################################################################
# Variables required on shell:
# - NODE_HOME
# - ROOT_DIR
# - ZOWE_EXPLORER_HOST
# - GATEWAY_PORT
# - MVS_EXPLORER_UI_PORT
# - KEYSTORE_KEY
# - KEYSTORE_CERTIFICATE

NODE_BIN=${NODE_HOME}/bin/node

cd "$ROOT_DIR/components/explorer-mvs/bin"
EXPLORER_PLUGIN_BASEURI=$($NODE_BIN -e "process.stdout.write(require('./app/package.json').config.baseuri)")
EXPLORER_PLUGIN_NAME=$($NODE_BIN -e "process.stdout.write(require('./app/package.json').config.pluginName)")

# get current ui server directory
SERVER_DIR="${ROOT_DIR}/components/explorer-mvs/bin/server/"

# start service
$NODE_BIN $SERVER_DIR/src/index.js \
  --service ${EXPLORER_PLUGIN_NAME} \
	--path ${EXPLORER_PLUGIN_BASEURI} \
	--port ${MVS_EXPLORER_UI_PORT} \
	--key  ${KEYSTORE_KEY} \
	--cert ${KEYSTORE_CERTIFICATE} \
	--csp "${ZOWE_EXPLORER_HOST}:*" \
	-v &
