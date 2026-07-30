
inherit coverity

DEPENDS += " nanomsg"

do_install:append() {
    if ${@bb.utils.contains('DISTRO_FEATURES', 'dhcp_manager', 'true', 'false', d)}; then
        sed -i 's/PsmSsp.service/& ApplySystemDefaults.service/' ${D}/lib/systemd/system/CcspDHCPMgr.service
    fi
}
