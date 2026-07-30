#!/bin/sh
#Below files needs to be placed under /nvram folder before onewifi_em_cli process starts

EM_STATIC_DIR="/nvram/static"
EM_JSON_FILE="/nvram/Reset.json"

if [ ! -d $EM_STATIC_DIR ]; then
   cp -rf /usr/ccsp/EasyMesh/static $EM_STATIC_DIR
   echo "$EM_STATIC_DIR is created"
fi

if [ ! -f $EM_JSON_FILE ]; then
   cp /usr/ccsp/EasyMesh/Reset.json $EM_JSON_FILE
   echo "$EM_JSON_FILE is created"
fi
