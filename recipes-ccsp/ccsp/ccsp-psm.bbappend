DEPENDS += "cjson"
DEPENDS:remove = "mountutils"

LDFLAGS += "-lcjson"

PV_kirkstone = "${RDK_RELEASE}+git${SRCPV}"

TARGET_CFLAGS += "-Wno-error=address"
