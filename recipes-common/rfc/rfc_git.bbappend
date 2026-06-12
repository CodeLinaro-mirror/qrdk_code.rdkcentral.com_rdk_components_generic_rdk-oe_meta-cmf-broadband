FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append = " git://github.com/rdkcentral/broadband-utils.git;protocol=https;branch=develop;name=utils;destsuffix=git/broadband"
SRCREV_utils = "ccbe5d245ed966f1fc771064b648f6630acf98a6"
SRCREV_FORMAT = "rfc_utils"

DEPENDS:append = " hal-platform"
LDFLAGS:append = " -lhal_platform "

SRC_URI:append  += " file://RFCpostprocess.sh "
SRC_URI:append  += " file://RFC_Reboot.sh "

do_configure:prepend(){
    cp ${S}/broadband/rfc-utils/mtlsUtils.h ${S}/rfcMgr/mtlsUtils.h
    cp ${S}/broadband/rfc-utils/mtlsUtils.cpp ${S}/rfcMgr/mtlsUtils.cpp
}

do_install:append() {
       install -m 0755 ${S}/../RFCpostprocess.sh ${D}${base_libdir}/rdk/RFCpostprocess.sh
       install -m 0755 ${S}/../RFC_Reboot.sh ${D}${sysconfdir}/RFC_Reboot.sh
}
