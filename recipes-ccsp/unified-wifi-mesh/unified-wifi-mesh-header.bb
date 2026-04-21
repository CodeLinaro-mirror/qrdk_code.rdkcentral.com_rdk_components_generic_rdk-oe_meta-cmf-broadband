SUMMARY = "Unified-wifi-mesh header files installation"
HOMEPAGE = "http://github.com/rdkcentral/unified-wifi-mesh"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=e0b1ae637439c7d6f4487fb90163c79a"

SRC_URI = "git://github.com/rdkcentral/unified-wifi-mesh.git;nobranch=1;protocol=https;name=Unified-wifi-mesh_header"
PV = "v0.2.1"
SRCREV_Unified-wifi-mesh_header = "8780ce2e9299b8fe17804ea996c86acf15be0526"
SRCREV_FORMAT = "Unified-wifi-mesh_header"

S = "${WORKDIR}/git"

do_install() {
    install -d ${D}/usr/include/ccsp
    install -m 644 ${S}/inc/*  ${D}/usr/include/ccsp
}

FILES_${PN} += "/usr/include/ccsp/* "
