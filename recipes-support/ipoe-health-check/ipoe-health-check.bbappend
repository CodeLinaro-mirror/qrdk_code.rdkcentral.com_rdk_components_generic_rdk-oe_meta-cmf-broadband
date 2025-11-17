inherit coverity pkgconfig
DEPENDS += "msgpack-c"
LDFLAGS += "`pkg-config --libs msgpack-c`"
RDEPENDS:${PN} += "msgpack-c"
