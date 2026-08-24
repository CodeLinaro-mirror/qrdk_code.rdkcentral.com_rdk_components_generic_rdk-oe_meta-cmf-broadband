inherit coverity

SRC_URI = "${@bb.utils.contains('DISTRO_FEATURES', 'BuildFromTip', 'git://github.com/rdkcentral/OneWifi.git;protocol=https;branch=develop;name=OneWifi', 'git://github.com/rdkcentral/OneWifi.git;protocol=https;nobranch=1;name=OneWifi', d)}"
SRCREV_OneWifi = "${@bb.utils.contains('DISTRO_FEATURES', 'BuildFromTip', '${AUTOREV}', '595a697fe1f6c443b5b5fb29a32cfb18f0702ac7', d)}"
SRCREV_FORMAT = "OneWifi"

DEPENDS_append = " mesh-agent "
DEPENDS_remove = " opensync "
DEPENDS_append = " protobuf-c"
RDEPENDS_${PN}_append = " openvswitch"
DEPENDS += " ${@bb.utils.contains('DISTRO_FEATURES', 'EasyMesh', ' rdk-wifi-libhostap ', '', d)}"

CFLAGS_append = " -DWIFI_HAL_VERSION_3 -Wno-unused-function "
LDFLAGS_append = " -ldl"
LDFLAGS_remove = " -ldpp"
CFLAGS_append_aarch64 = " -Wno-error "

EXTRA_OECONF_append = " ${@bb.utils.contains('DISTRO_FEATURES', 'EasyMesh', ' --enable-em-app ', '', d)}"
CFLAGS_append = " ${@bb.utils.contains('DISTRO_FEATURES', 'EasyMesh', ' -DEASY_MESH_NODE ', '', d)}"
CFLAGS_append = " ${@bb.utils.contains('DISTRO_FEATURES', 'sta_manager', '-DONEWIFI_STA_MGR_APP_SUPPORT', '', d)}"
EXTRA_OECONF_remove = " ${@bb.utils.contains('DISTRO_FEATURES', 'EasyMesh', ' ONEWIFI_CAC_APP_SUPPORT=true ', '', d)}"
CFLAGS_remove = " ${@bb.utils.contains('DISTRO_FEATURES', 'EasyMesh', ' -DONEWIFI_CAC_APP_SUPPORT -DONEWIFI_DB_SUPPORT  ', '', d)}"
CFLAGS_append = " ${@bb.utils.contains('DISTRO_FEATURES', 'generic_mlo', ' -DCONFIG_GENERIC_MLO ', '', d)}"
