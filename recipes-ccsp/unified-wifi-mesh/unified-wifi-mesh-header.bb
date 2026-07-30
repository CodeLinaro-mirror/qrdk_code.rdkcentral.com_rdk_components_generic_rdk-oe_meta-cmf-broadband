SUMMARY = "Unified-wifi-mesh header files installation"
HOMEPAGE = "http://github.com/rdkcentral/unified-wifi-mesh"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=e0b1ae637439c7d6f4487fb90163c79a"

SRC_URI = "${@bb.utils.contains('DISTRO_FEATURES', 'BuildFromTip', 'git://github.com/rdkcentral/unified-wifi-mesh.git;branch=develop;protocol=https;name=Unified-wifi-mesh_header', 'git://github.com/rdkcentral/unified-wifi-mesh.git;nobranch=1;protocol=https;name=Unified-wifi-mesh_header', d)}"
PV = "v0.3.1"

S = "${UNPACKDIR}/${PN}-${PV}"
SRCREV_Unified-wifi-mesh_header = "${@d.getVar('AUTOREV') if bb.utils.contains('DISTRO_FEATURES', 'BuildFromTip', True, False, d) else 'cba4980a1b880ca6f11c479ecb62a7544fa6a42d'}"
SRCREV_FORMAT = "Unified-wifi-mesh_header"


do_install() {
    install -d ${D}/usr/include/ccsp
    install -m 644 ${S}/inc/*  ${D}/usr/include/ccsp
}

FILES:${PN} += "/usr/include/ccsp/* "
