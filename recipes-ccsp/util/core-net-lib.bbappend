inherit coverity
CPPFLAGS:append = " -I${RECIPE_SYSROOT}/usr/include/safeclib"

CFLAGS:append = " -Wno-int-conversion"
