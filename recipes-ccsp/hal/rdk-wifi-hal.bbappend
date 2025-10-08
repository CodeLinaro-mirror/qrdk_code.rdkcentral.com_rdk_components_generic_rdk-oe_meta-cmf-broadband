inherit coverity

DEPENDS:remove = "mountutils"

#CFLAGS += "-Wno-deprecated-declarations"
#CFLAGS += "-Wno-error=address"
#CFLAGS += "-Wno-error=enum-conversion"

TARGET_CFLAGS += " \
    -Wno-error=deprecated-declarations \
    -Wno-error=address \
    -Wno-error=enum-conversion \
"
