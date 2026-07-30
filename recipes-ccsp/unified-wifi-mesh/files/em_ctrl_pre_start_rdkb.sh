#!/bin/sh
#Below files needs to be placed in /nvram folder before Easymesh controller starts

EM_JSON_CFG="/nvram/EasymeshCfg.json"
EM_DATA_EL_SCHEMA="/nvram/Data_Elements_JSON_Schema_v3.0.json"

echo "Starting $0"

# Ensure EasymeshCfg.json exists in /nvram
if [ ! -f "$EM_JSON_CFG" ]; then
    cp /usr/ccsp/EasyMesh/EasymeshCfg.json "$EM_JSON_CFG"
    echo "$EM_JSON_CFG is created"
fi

# Ensure Data_Elements_JSON_Schema_v3.0.json exists in /nvram
if [ ! -f "$EM_DATA_EL_SCHEMA" ]; then
    cp /usr/ccsp/EasyMesh/Data_Elements_JSON_Schema_v3.0.json $EM_DATA_EL_SCHEMA
    echo "$EM_DATA_EL_SCHEMA is created"
fi

# Ensure easymesh cert crt exists in /nvram
if [ ! -f /nvram/test_cert.crt ]; then
    cp /usr/ccsp/EasyMesh/test_cert.* /nvram
    cp /usr/ccsp/EasyMesh/create-cert /nvram
    echo "Copied easymesh cert crt and key to /nvram"
fi
