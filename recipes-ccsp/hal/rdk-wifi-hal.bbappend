inherit coverity

DEPENDS:remove = "mountutils"

CFLAGS:append:wrynose = " -Wno-deprecated-declarations -Wno-enum-conversion"
