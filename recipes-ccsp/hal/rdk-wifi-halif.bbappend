SRC_URI_remove_onewifi = "git://github.com/rdkcentral/rdkb-halif-wifi.git;protocol=https;branch=main"
SRC_URI_onewifi = "${@bb.utils.contains('DISTRO_FEATURES', 'BuildFromTip', 'git://github.com/rdkcentral/rdkb-halif-wifi.git;protocol=https;branch=develop', 'git://github.com/rdkcentral/rdkb-halif-wifi.git;protocol=https;nobranch=1', d)}"
SRCREV_onewifi = "${@bb.utils.contains('DISTRO_FEATURES', 'BuildFromTip', '${AUTOREV}', 'b7fbc81c94d8d9a5ade5044d4f164f76abe1aae0', d)}"
