SUMMARY = "Unified-wifi-mesh header files installation"
HOMEPAGE = "http://github.com/rdkcentral/unified-wifi-mesh"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=e0b1ae637439c7d6f4487fb90163c79a"

SRC_URI = "${@bb.utils.contains('DISTRO_FEATURES', 'BuildFromTip', 'git://github.com/rdkcentral/unified-wifi-mesh.git;branch=develop;protocol=https;name=Unified-wifi-mesh_header', 'git://github.com/rdkcentral/unified-wifi-mesh.git;nobranch=1;protocol=https;name=Unified-wifi-mesh_header', d)}"
PV = "v0.3.1"
SRCREV_Unified-wifi-mesh_header = "${@bb.utils.contains('DISTRO_FEATURES', 'BuildFromTip', '${AUTOREV}', 'c0e72a31c96cc63cc366fcf2b628132185985d2a', d)}"
SRCREV_FORMAT = "Unified-wifi-mesh_header"

S = "${WORKDIR}/git"

do_install() {
    install -d ${D}/usr/include/ccsp
    install -m 644 ${S}/inc/*  ${D}/usr/include/ccsp
}

FILES:${PN} += "/usr/include/ccsp/* "
