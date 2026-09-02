
inherit coverity

DEPENDS += " nanomsg"

do_install:append() {
   sed -i 's/PsmSsp.service/& ApplySystemDefaults.service/' ${D}${systemd_unitdir}/system/CcspDHCPMgr.service
}
