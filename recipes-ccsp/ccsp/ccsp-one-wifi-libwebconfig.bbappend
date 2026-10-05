inherit coverity

SRC_URI = "${@bb.utils.contains('DISTRO_FEATURES', 'BuildFromTip', 'git://github.com/rdkcentral/OneWifi.git;protocol=https;branch=develop;name=libwebconfig', 'git://github.com/rdkcentral/OneWifi.git;protocol=https;nobranch=1;name=libwebconfig', d)}"
SRCREV_libwebconfig = "${@d.getVar('AUTOREV') if bb.utils.contains('DISTRO_FEATURES', 'BuildFromTip', True, False, d) else 'af7acb05796cd6292ab05fd1ea368bdcb7549a9e'}"

DEPENDS += " ${@bb.utils.contains('DISTRO_FEATURES', 'EasyMesh', ' rdk-wifi-libhostap unified-wifi-mesh-header ', '', d)}"
EXTRA_OECONF:append = " ${@bb.utils.contains('DISTRO_FEATURES', 'EasyMesh', ' --enable-easymesh ', '', d)}"
EXTRA_OECONF:append = " ${@bb.utils.contains('DISTRO_FEATURES', 'EasyMesh', ' --enable-em-app ', '', d)}"

EXTRA_OECONF:append = " ${@bb.utils.contains('DISTRO_FEATURES', 'EasyMesh', ' --enable-em-app ', '', d)}"

CFLAGS += " -Wno-enum-conversion "
CFLAGS += " ${@bb.utils.contains('DISTRO_FEATURES', 'EasyMesh', ' -Wno-error=maybe-uninitialized -Wno-error=unused-variable -Wno-error=unused-but-set-variable -Wno-error=incompatible-pointer-types -Wno-error=sign-compare -Wno-error -DEASY_MESH_NODE  ', '', d)}"
CFLAGS:append = " ${@bb.utils.contains('DISTRO_FEATURES', 'generic_mlo', ' -DCONFIG_GENERIC_MLO ', '', d)}"

do_install:append() {
      install -m 644 ${S}/include/webconfig_external_proto_easymesh.h  ${D}/usr/include/ccsp
}
