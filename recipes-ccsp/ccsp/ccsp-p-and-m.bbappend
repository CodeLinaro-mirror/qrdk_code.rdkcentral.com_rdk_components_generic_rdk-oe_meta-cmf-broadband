DEPENDS:remove = "mountutils"

CFLAGS:append  += " ${@bb.utils.contains('DISTRO_FEATURES', 'rdkb_cellular_manager_mm', ' -DFEATURE_RDKB_CELLULAR_MANAGER', '', d)}"
CFLAGS:append = " -DRBUS_WAN_IP "
