inherit coverity

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"
SRC_URI_remove = "git://github.com/rdkcentral/rdk-wifi-hal.git;protocol=https;branch=main;name=rdk-wifi-hal"
SRC_URI += "${@bb.utils.contains('DISTRO_FEATURES', 'BuildFromTip', 'git://github.com/rdkcentral/rdk-wifi-hal.git;protocol=https;branch=develop;name=rdk-wifi-hal', 'git://github.com/rdkcentral/rdk-wifi-hal.git;protocol=https;nobranch=1;name=rdk-wifi-hal', d)}"
SRC_URI += "${@bb.utils.contains('DISTRO_FEATURES', 'EasyMesh', bb.utils.contains('DISTRO_FEATURES', 'em_extender', 'file://EasymeshCfg_ext.json ','file://EasymeshCfg.json ', d), ' ', d)}"
SRCREV_rdk-wifi-hal = "${@bb.utils.contains('DISTRO_FEATURES', 'BuildFromTip', '${AUTOREV}', 'ce3170c9c8710a44b4627248e1443c31a9f7ad43', d)}"

DEPENDS_remove = "mountutils"

CFLAGS_append = " ${@bb.utils.contains('DISTRO_FEATURES', 'generic_mlo', ' -DCONFIG_GENERIC_MLO -DCONFIG_MLO ', '', d)}"
CFLAGS_append = " ${@bb.utils.contains('DISTRO_FEATURES', 'EasyMesh', ' -DEASY_MESH_NODE  ', '', d)}"

do_install_append() {
     DISTRO_EM_ENABLED="${@bb.utils.contains('DISTRO_FEATURES','EasyMesh','true','false',d)}"
     if [ $DISTRO_EM_ENABLED = 'true' ]; then
        install -d ${D}/usr/ccsp/EasyMesh
        install -m 0644 ${WORKDIR}/Easymesh*.json  ${D}/usr/ccsp/EasyMesh/EasymeshCfg.json
     fi
}

FILES_${PN}_append = "${@bb.utils.contains('DISTRO_FEATURES', 'EasyMesh', ' /usr/ccsp/EasyMesh/* ', '', d)}"
