SRC_URI:remove_onewifi = "git://github.com/rdkcentral/rdkb-halif-wifi.git;protocol=https;branch=main"
SRC_URI_onewifi = "${@bb.utils.contains('DISTRO_FEATURES', 'BuildFromTip', 'git://github.com/rdkcentral/rdkb-halif-wifi.git;protocol=https;branch=develop', 'git://github.com/rdkcentral/rdkb-halif-wifi.git;protocol=https;nobranch=1', d)}"
SRCREV_onewifi = "${@d.getVar('AUTOREV') if bb.utils.contains('DISTRO_FEATURES', 'BuildFromTip', True, False, d) else '3574df11ad7da3ac5407afe5970e974be64e9c9b'}"
