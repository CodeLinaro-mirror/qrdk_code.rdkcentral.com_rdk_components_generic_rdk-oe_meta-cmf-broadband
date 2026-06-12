FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += "file://udhcpc.script"
SRC_URI += "file://udhcpc.vendor_specific"
SRC_URI += "file://dhcpswitch.sh"

SRC_URI  += " ${@bb.utils.contains('DISTRO_FEATURES', 'device_gateway_association', 'file://Device_Gateway_Association.patch;apply=no', '', d)}"

SRC_URI:append += "${@bb.utils.contains('DISTRO_FEATURES','WanFailOverSupportEnable','file://udhcpc_backupwan.script','',d)}"
IsRdkbWanFailOverSupported = "${@bb.utils.contains('DISTRO_FEATURES', 'WanFailOverSupportEnable', 'true', 'false', d)}"

DEPENDS += " nanomsg libupnp"

CFLAGS:append = " ${@bb.utils.contains('DISTRO_FEATURES', 'rdkb_wan_manager', '-D_WAN_MANAGER_ENABLED_', '', d)}"
CFLAGS:remove_dunfell = "-Wno-enum-conversion"

LDFLAGS += " -lpthread -lhal_platform -lccsp_common -lsafec"

#RDKBDEV-83 -Patch code based on distro
do_utopia_patches() {
if [ "${@bb.utils.contains("DISTRO_FEATURES", "device_gateway_association", "yes", "no", d)}" = "yes" ]; then    
    cd ${S} 
    if [ ! -e patch_applied ]; then
        patch -p1 < ${UNPACKDIR}/Device_Gateway_Association.patch
        touch patch_applied
    fi
fi
}
addtask utopia_patches after do_unpack before do_compile

do_configure:append() {
    sed -i \
        's|static int[[:space:]]*syscfg_shm_init[[:space:]]*();|static int syscfg_shm_init(syscfg_shm_ctx **out_ctx);|' \
        ${S}/source/syscfg/lib/syscfg_lib.h

    sed -i \
        's/prepare_dhcp_conf();/prepare_dhcp_conf(NULL);/g' \
        ${S}/source/service_dhcp/service_dhcp_server.c

    sed -i -E \
        's/int[[:space:]]+prepare_dhcp_conf[[:space:]]*\(\s*\);/int prepare_dhcp_conf(char *);/' \
        ${S}/source/service_dhcp/include/dhcp_server_functions.h
}
do_compile:prepend() {
    # Make sure staging libdir exists
    install -d ${STAGING_LIBDIR}

    # Create symlink so -lthreadutil resolves to libupnp
    ln -sf libupnp.so ${STAGING_LIBDIR}/libthreadutil.so
}

do_install:append () {
    if [ "${IsRdkbWanFailOverSupported}" = "true" ]; then
        install -d ${D}${sysconfdir}/
        install -m 755 ${UNPACKDIR}/udhcpc_backupwan.script ${D}${sysconfdir}/
    fi
}

FILES:${PN} += "${@bb.utils.contains('DISTRO_FEATURES','WanFailOverSupportEnable','${sysconfdir}/udhcpc_backupwan.script','',d)}"

