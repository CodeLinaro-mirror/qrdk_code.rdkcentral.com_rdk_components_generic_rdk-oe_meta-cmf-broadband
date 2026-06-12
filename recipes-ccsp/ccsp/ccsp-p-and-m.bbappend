DEPENDS:remove = "mountutils"

CFLAGS:append  += " ${@bb.utils.contains('DISTRO_FEATURES', 'rdkb_cellular_manager_mm', ' -DFEATURE_RDKB_CELLULAR_MANAGER', '', d)}"
CFLAGS:append = " -DRBUS_WAN_IP "

CFLAGS:append = "${@bb.utils.contains("DISTRO_FEATURES", "resource_optimization", " -DRESOURCE_OPTIMIZATION ", " ", d)} "
ENABLE_RESOURCE_OPTIMIZATION = "--enable-resourceoptimization=${@bb.utils.contains('DISTRO_FEATURES', 'resource_optimization', 'yes', 'no', d)}"
EXTRA_OECONF:append = " ${ENABLE_RESOURCE_OPTIMIZATION}"

do_compile:prepend () {
    if ${@bb.utils.contains('DISTRO_FEATURES', 'resource_optimization', 'true', 'false', d)}; then
        sed -i '2i <?define FEATURE_RESOURCE_OPTIMIZATION=True?>' ${S}/config-arm/TR181-USGv2.XML
    fi

    if ${@bb.utils.contains('CFLAGS', '-DRBUS_WAN_IP', 'true', 'false', d)}; then
        sed -i '2i <?define RBUS_WAN_IP=True?>' ${S}/config-arm/TR181-USGv2.XML
    fi
}
