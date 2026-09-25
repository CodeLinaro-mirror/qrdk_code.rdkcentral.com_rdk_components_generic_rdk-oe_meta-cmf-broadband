SUMMARY = "Unified-wifi-mesh"
HOMEPAGE = "http://github.com/rdkcentral/unified-wifi-mesh"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=e0b1ae637439c7d6f4487fb90163c79a"

FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI = "${@bb.utils.contains('DISTRO_FEATURES', 'BuildFromTip', 'git://github.com/rdkcentral/unified-wifi-mesh.git;branch=develop;protocol=https;name=Unified-wifi-mesh', 'git://github.com/rdkcentral/unified-wifi-mesh.git;nobranch=1;protocol=https;name=Unified-wifi-mesh', d)}"
PV_Unified-wifi-mesh = "v0.3.1"
SRCREV_Unified-wifi-mesh = "${@d.getVar('AUTOREV') if bb.utils.contains('DISTRO_FEATURES', 'BuildFromTip', True, False, d) else 'c0e72a31c96cc63cc366fcf2b628132185985d2a'}"

SRCREV_FORMAT = "Unified-wifi-mesh"

SRC_URI += " ${@bb.utils.contains('DISTRO_FEATURES', 'em_extender', ' file://ext_em_agent.service', ' file://em_agent.service', d)}"
SRC_URI += " ${@bb.utils.contains('DISTRO_FEATURES', 'em_extender', '', ' file://em_ctrl.service', d)}"
SRC_URI += " ${@bb.utils.contains('DISTRO_FEATURES', 'em_extender', '', ' file://em_cli.service', d)}"
SRC_URI += " ${@bb.utils.contains('DISTRO_FEATURES', 'em_extender', '', ' file://setup_mysql_db_pre.sh', d)}"
SRC_URI += " ${@bb.utils.contains('DISTRO_FEATURES', 'em_extender', '', ' file://setup_mysql_db_post.sh', d)}"
SRC_URI += " ${@bb.utils.contains('DISTRO_FEATURES', 'em_extender', ' file://setup_ext_pre.sh', '', d)}"
SRC_URI:append:wrynose = " file://wrynose-easymesh-runtime-issue.patch"

S = "${UNPACKDIR}/${PN}-${PV}"

DEPENDS = " ccsp-one-wifi rbus rdk-wifi-halif mariadb gtest breakpad breakpad-wrapper"
DEPENDS += "gcc-sanitizers"
RDEPENDS:${PN} += "${@bb.utils.contains('DISTRO_FEATURES', 'em_extender', ' ', ' mariadb', d)}"

inherit autotools pkgconfig systemd breakpad-wrapper
CFLAGS += "-I${STAGING_INCDIR}/breakpad "
CXXFLAGS += "-I${STAGING_INCDIR}/breakpad "

CPPFLAGS:append = " \
    -I${STAGING_INCDIR} \
    -I${STAGING_INCDIR}/rbus \
    -I${STAGING_INCDIR}/ccsp \
    -I${STAGING_INCDIR}/dbus-1.0 \
    -I${STAGING_LIBDIR}/dbus-1.0/include \
"
CPPFLAGS:append = " -g -DEASY_MESH_NODE -DEM_APP -std=c++17 -D_PLATFORM_BANANAPI_R4_ "
CPPFLAGS:append = " ${@bb.utils.contains('DISTRO_FEATURES', 'with_alsap',' -DAL_SAP', '', d)}"
CFLAGS:append = " -D_PLATFORM_BANANAPI_R4_ "

LDFLAGS:append = " \
    -lm \
    -lsafec \
    -lcjson \
    -lpthread \
    -ldl \
    -luuid \
    -lssl \
    -lcrypto \
    -lrbus \
    -lbreakpadwrapper \
    -lwifi_bus \
"
EXTRA_OECONF:append = " ${@bb.utils.contains('DISTRO_FEATURES', 'em_extender', 'EM_EXTENDER=true', 'EM_EXTENDER=false', d)}"
#To enable unit test support
EXTRA_OECONF:append = " ${@bb.utils.contains('DISTRO_FEATURES', 'Em_Unittest', 'EM_UNITTEST=true', 'EM_UNITTEST=false', d)}"

#minidump support
BREAKPAD_BIN:append = " onewifi_em_ctrl "
BREAKPAD_BIN:append = " onewifi_em_agent"

do_install:append() {
    install -d ${D}/usr/ccsp/EasyMesh
    install -d ${D}${systemd_unitdir}/system
    install -m 644 ${S}/install/bin/*  ${D}/usr/ccsp/EasyMesh
    install -m 755 ${S}/config/rdkb/banana-pi/setup_veth*.sh  ${D}/usr/ccsp/EasyMesh
    install -m 755 ${UNPACKDIR}/setup_*.sh ${D}/usr/ccsp/EasyMesh
    DISTRO_EM_EXT_ENABLED="${@bb.utils.contains('DISTRO_FEATURES','em_extender','true','false',d)}"
    if [ $DISTRO_EM_EXT_ENABLED = 'true' ]; then
       cp ${UNPACKDIR}/ext_em_agent.service ${UNPACKDIR}/em_agent.service
    else
       install -m 664 ${S}/install/config/*  ${D}/usr/ccsp/EasyMesh
    fi
    install -D -m 0644 ${UNPACKDIR}/em_*.service ${D}${systemd_unitdir}/system/

    #Needed for WFA Data Elements.
    install -m 755 ${UNPACKDIR}/${BP}/src/ctrl/tr_181/wfa_data_model/Data_Elements_JSON_Schema_v3.0.json ${D}/usr/ccsp/EasyMesh
}

do_configure:prepend:wrynose() {
    sed -i '/#include <vector>/a #include <algorithm>' ${S}/inc/util.h
}

SYSTEMD_SERVICE:${PN} = " em_agent.service"
SYSTEMD_SERVICE:${PN} += " ${@bb.utils.contains('DISTRO_FEATURES','em_extender','',' em_ctrl.service em_cli.service ',d)}"

FILES:${PN} += "${libdir}/*.so*  ${bindir}/* /usr/ccsp/EasyMesh/* "
FILES:${PN} += "${systemd_unitdir}/system/* "
