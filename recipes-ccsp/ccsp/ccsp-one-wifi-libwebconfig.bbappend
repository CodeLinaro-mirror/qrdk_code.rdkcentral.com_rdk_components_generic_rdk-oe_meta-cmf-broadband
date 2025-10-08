inherit coverity

TARGET_CFLAGS += "-Wno-error=address"
FILES:${PN}-dev += "${libdir}/*.so"
