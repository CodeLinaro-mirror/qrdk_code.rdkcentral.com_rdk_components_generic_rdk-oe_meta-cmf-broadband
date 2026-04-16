# Ensure Rust and Cargo are available
inherit cargo systemd breakpad-wrapper

DESCRIPTION = "IEEE 1905 Rust Program"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=b538373fe584898492d2ad3a91014d58"

FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

# Source repository
SRC_URI = "${@bb.utils.contains('DISTRO_FEATURES', 'BuildFromTip', 'git://github.com/rdkcentral/ieee1905-rs.git;branch=develop;protocol=https', 'git://github.com/rdkcentral/ieee1905-rs.git;nobranch=1;protocol=https', d)}"
SRCREV = "${@bb.utils.contains('DISTRO_FEATURES', 'BuildFromTip', '${AUTOREV}', '9eb6127c05250f0174a113688d7e577e1af35732', d)}"
PV = "v0.6.0"

SRC_URI += "\
     ${@bb.utils.contains('DISTRO_FEATURES','em_extender',' file://ieee1905_em_ext_agent.service ',' file://ieee1905_em_agent.service ',d)} \
     ${@bb.utils.contains('DISTRO_FEATURES','em_extender',' ',' file://ieee1905_em_ctrl.service ',d)} \
"

#Breakpad support
DEPENDS = "breakpad breakpad-wrapper"
DEPENDS += " clang-native rbus "
CFLAGS += "-I${STAGING_INCDIR}/breakpad "
CXXFLAGS += "-I${STAGING_INCDIR}/breakpad "

export LIBCLANG_PATH = "${STAGING_LIBDIR_NATIVE}"

LDFLAGS:append = " \
    -lbreakpadwrapper \
    -lrbus \
"

RUSTFLAGS += "-L ${STAGING_LIBDIR} -l rbus --cfg tokio_unstable"
BREAKPAD_BIN:append = " ieee1905-em"

# Source directory
S = "${WORKDIR}/git"

#dependencies from crates.io
require includes/ieee1905_dependencies.inc

do_install:append() {
    install -d ${D}${systemd_unitdir}/system
    install -D -m 0644 ${WORKDIR}/ieee1905_*.service ${D}${systemd_unitdir}/system/
    DISTRO_EM_EXT_ENABLED="${@bb.utils.contains('DISTRO_FEATURES','em_extender','true','false',d)}"
    if [ $DISTRO_EM_EXT_ENABLED = 'true' ]; then
       mv ${D}${systemd_unitdir}/system/ieee1905_em_ext_agent.service ${D}${systemd_unitdir}/system/ieee1905_em_agent.service
    fi
}

SYSTEMD_SERVICE:${PN} = " ${@bb.utils.contains('DISTRO_FEATURES','em_extender','',' ieee1905_em_ctrl.service',d)}"
SYSTEMD_SERVICE:${PN} += " ieee1905_em_agent.service"

FILES:${PN} += " \
    /usr/bin/* \
    ${systemd_unitdir}/system/* \
"

INSANE_SKIP:${PN} = "already-stripped"
