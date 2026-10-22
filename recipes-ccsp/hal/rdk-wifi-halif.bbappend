SRC_URI_remove_onewifi = "git://github.com/rdkcentral/rdkb-halif-wifi.git;protocol=https;branch=main"
SRC_URI_onewifi = "${@bb.utils.contains('DISTRO_FEATURES', 'BuildFromTip', 'git://github.com/rdkcentral/rdkb-halif-wifi.git;protocol=https;branch=develop', 'git://github.com/rdkcentral/rdkb-halif-wifi.git;protocol=https;nobranch=1', d)}"
SRCREV_onewifi = "${@bb.utils.contains('DISTRO_FEATURES', 'BuildFromTip', '${AUTOREV}', 'ca1bb7e441c2f286f24a93d9c361874a86fbf82d', d)}"
