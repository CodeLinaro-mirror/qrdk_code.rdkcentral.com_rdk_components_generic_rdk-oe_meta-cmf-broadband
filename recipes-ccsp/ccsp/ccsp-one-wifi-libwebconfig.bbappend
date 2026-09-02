inherit coverity

SRC_URI = "${@bb.utils.contains('DISTRO_FEATURES', 'BuildFromTip', 'git://github.com/rdkcentral/OneWifi.git;protocol=https;branch=develop;name=libwebconfig', 'git://github.com/rdkcentral/OneWifi.git;protocol=https;nobranch=1;name=libwebconfig', d)}"
SRCREV_libwebconfig = "${@bb.utils.contains('DISTRO_FEATURES', 'BuildFromTip', '${AUTOREV}', '6281b770f10654644c23e6f474c556cf913e41b4', d)}"

DEPENDS += " ${@bb.utils.contains('DISTRO_FEATURES', 'EasyMesh', ' rdk-wifi-libhostap unified-wifi-mesh-header ', '', d)}"
EXTRA_OECONF_append = " ${@bb.utils.contains('DISTRO_FEATURES', 'EasyMesh', ' --enable-easymesh ', '', d)}"
EXTRA_OECONF_append = " ${@bb.utils.contains('DISTRO_FEATURES', 'EasyMesh', ' --enable-em-app ', '', d)}"

EXTRA_OECONF_append = " ${@bb.utils.contains('DISTRO_FEATURES', 'EasyMesh', ' --enable-em-app ', '', d)}"

CFLAGS += " -Wno-enum-conversion "
CFLAGS += " ${@bb.utils.contains('DISTRO_FEATURES', 'EasyMesh', ' -Wno-error=maybe-uninitialized -Wno-error=unused-variable -Wno-error=unused-but-set-variable -Wno-error=incompatible-pointer-types -Wno-error=sign-compare -Wno-error -DEASY_MESH_NODE  ', '', d)}"

do_install_append() {
      install -m 644 ${S}/include/webconfig_external_proto_easymesh.h  ${D}/usr/include/ccsp
}
