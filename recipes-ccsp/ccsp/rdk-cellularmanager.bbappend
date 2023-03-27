SRC_URI_remove = "${RDKB_CCSP_ROOT_GIT}/RdkCellularManager/generic;protocol=${RDK_GIT_PROTOCOL};branch=${CCSP_GIT_BRANCH};name=CellularManager"
SRC_URI += "${CMF_GIT_ROOT}/collaboration/rdkb/components/opensource/ccsp/RdkCellularManager-MM;protocol=${CMF_GIT_PROTOCOL};branch=main;name=CellularManager-mm"

SRC_URI_append = " \
                file://qmi_wwan0.patch \
                "

SRCREV_CellularManager-mm = "${AUTOREV}"
SRCREV_FORMAT = "CellularManager-mm"

PV = "${RDK_RELEASE}+git${SRCPV}"

S = "${WORKDIR}/git"

inherit coverity

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

do_install_append () {
    install -d ${D}${systemd_unitdir}/system
}

DEPENDS_append += "modemmanager"

S = "${WORKDIR}/git"

CFLAGS += "-I${STAGING_INCDIR}/libmm-glib/"
CFLAGS += "-I${STAGING_INCDIR}/ModemManager/"
#CFLAGS += "-DQMI_SUPPORT"
CFLAGS += "-DMM_SUPPORT"
CFLAGS += "-DWITH_QMI"

LDFLAGS += "-lmm-glib"

DEPENDS += "breakpad breakpad-wrapper"

CFLAGS += "-I${STAGING_INCDIR}/breakpad "
CXXFLAGS += "-I${STAGING_INCDIR}/breakpad "

LDFLAGS += "-lbreakpadwrapper -lpthread"
