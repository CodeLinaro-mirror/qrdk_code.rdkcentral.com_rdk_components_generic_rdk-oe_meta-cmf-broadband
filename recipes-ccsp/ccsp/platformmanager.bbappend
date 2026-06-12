SRC_URI:remove = "${RDKB_CCSP_ROOT_GIT}/PlatformManager/generic;protocol=${RDK_GIT_PROTOCOL};branch=${CCSP_GIT_BRANCH};name=PlatformManager"
SRC_URI += "${CMF_GIT_ROOT}/rdkb/components/opensource/ccsp/PlatformManager;protocol=${CMF_GIT_PROTOCOL};branch=${CMF_GIT_BRANCH};name=PlatformManager"

inherit coverity

EXTRA_OECONF:remove = "--enable-wanmgr"

CFLAGS:append = " -Wno-error=unused-function "
