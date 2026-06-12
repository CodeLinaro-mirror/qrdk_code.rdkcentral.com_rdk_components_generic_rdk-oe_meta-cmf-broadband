FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
SRC_URI:append = " file://RDM_HTTPS_FLAG.patch"
DEPENDS:remove = "mountutils"
EXTRA_OECONF:remove = " --enable-mountutils=yes --enable-unittest"

FILES:${PN}:remove = "${libdir}/librdmopenssl.la"
