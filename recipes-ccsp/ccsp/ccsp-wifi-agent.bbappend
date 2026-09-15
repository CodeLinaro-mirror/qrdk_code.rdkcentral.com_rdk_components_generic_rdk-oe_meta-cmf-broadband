SRC_URI:remove = "${CMF_GIT_ROOT}/rdkb/components/opensource/ccsp/CcspWifiAgent;protocol=${CMF_GIT_PROTOCOL};branch=${CMF_GIT_BRANCH};name=CcspWifiAgent"
SRC_URI += "${CMF_GIT_ROOT}/rdkb/components/opensource/ccsp/CcspWifiAgent;protocol=${CMF_GIT_PROTOCOL};branch=${CMF_GIT_MAIN_BRANCH};name=CcspWifiAgent;"

CFLAGS:append:wrynose = " \
    -Wno-error=implicit-function-declaration \
"
do_configure:prepend:wrynose() {
    sed -i '/msgpack_pack_str_with_body/,+5d' \
        ${S}/source/TR-181/sbapi/jsonconv.c
}
