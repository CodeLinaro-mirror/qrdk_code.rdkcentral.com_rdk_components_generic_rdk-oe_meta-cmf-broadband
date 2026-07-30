inherit coverity

SRC_URI = "${@bb.utils.contains('DISTRO_FEATURES', 'BuildFromTip', 'git://github.com/rdkcentral/OneWifi.git;protocol=https;branch=develop;name=OneWifi', 'git://github.com/rdkcentral/OneWifi.git;protocol=https;nobranch=1;name=OneWifi', d)}"

SRCREV_OneWifi = "${@d.getVar('AUTOREV') if bb.utils.contains('DISTRO_FEATURES', 'BuildFromTip', True, False, d) else 'af7acb05796cd6292ab05fd1ea368bdcb7549a9e'}"
SRCREV_FORMAT = "OneWifi"

DEPENDS:append = " mesh-agent "
DEPENDS:remove = " opensync "
DEPENDS:append = " protobuf-c"
RDEPENDS:${PN}:append = " openvswitch"
DEPENDS += " ${@bb.utils.contains('DISTRO_FEATURES', 'EasyMesh', ' rdk-wifi-libhostap ', '', d)}"

CFLAGS:append = " -DWIFI_HAL_VERSION_3 -Wno-unused-function "
LDFLAGS:append = " -ldl"
LDFLAGS:remove = " -ldpp"
CFLAGS:appends:aarch64 = " -Wno-error "

EXTRA_OECONF:append = " ${@bb.utils.contains('DISTRO_FEATURES', 'EasyMesh', ' --enable-em-app ', '', d)}"
CFLAGS:append = " ${@bb.utils.contains('DISTRO_FEATURES', 'EasyMesh', ' -DEASY_MESH_NODE ', '', d)}"
CFLAGS:append = " ${@bb.utils.contains('DISTRO_FEATURES', 'sta_manager', '-DONEWIFI_STA_MGR_APP_SUPPORT', '', d)}"
EXTRA_OECONF:remove = " ${@bb.utils.contains('DISTRO_FEATURES', 'EasyMesh', ' ONEWIFI_CAC_APP_SUPPORT=true ', '', d)}"
CFLAGS:remove = " ${@bb.utils.contains('DISTRO_FEATURES', 'EasyMesh', ' -DONEWIFI_CAC_APP_SUPPORT -DONEWIFI_DB_SUPPORT  ', '', d)}"
CFLAGS:append = " ${@bb.utils.contains('DISTRO_FEATURES', 'generic_mlo', ' -DCONFIG_GENERIC_MLO ', '', d)}"

