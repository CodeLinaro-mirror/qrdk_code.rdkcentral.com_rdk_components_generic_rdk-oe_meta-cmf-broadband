do_install:append () {
    install -m 644 ${S}/source/hotspotfd/include/debug.h ${D}${includedir}/ccsp
    install -m 644 ${S}/source/hotspotfd/include/dhcp.h ${D}${includedir}/ccsp
}
