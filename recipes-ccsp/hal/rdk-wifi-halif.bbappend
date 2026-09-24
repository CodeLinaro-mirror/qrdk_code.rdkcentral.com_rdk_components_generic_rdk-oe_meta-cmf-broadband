SRC_URI:remove:onewifi = "git://github.com/rdkcentral/rdkb-halif-wifi.git;protocol=https;branch=main"
SRC_URI:onewifi = "${@bb.utils.contains('DISTRO_FEATURES', 'BuildFromTip', 'git://github.com/rdkcentral/rdkb-halif-wifi.git;protocol=https;branch=develop', 'git://github.com/rdkcentral/rdkb-halif-wifi.git;protocol=https;nobranch=1', d)}"
SRCREV:onewifi = "${@d.getVar('AUTOREV') if bb.utils.contains('DISTRO_FEATURES', 'BuildFromTip', True, False, d) else 'f80754740d78b57c5512f549bc56e7e328d75198'}"
