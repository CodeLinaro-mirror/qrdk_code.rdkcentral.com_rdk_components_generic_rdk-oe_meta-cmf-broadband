# Add flags to support mesh wifi if the feature is available.
CFLAGS_append = " ${@bb.utils.contains('DISTRO_FEATURES', 'meshwifi', '-DENABLE_FEATURE_MESHWIFI', '', d)}"

inherit coverity

SRC_URI_remove = "git://github.com/rdkcentral/rdk-wifi-hal.git;protocol=https;branch=main;name=rdk-wifi-util"

SRC_URI = "${@bb.utils.contains('DISTRO_FEATURES', 'BuildFromTip', 'git://github.com/rdkcentral/rdk-wifi-hal.git;protocol=https;branch=develop;name=rdk-wifi-util', 'git://github.com/rdkcentral/rdk-wifi-hal.git;protocol=https;nobranch=1;name=rdk-wifi-util', d)}"
SRCREV_rdk-wifi-util = "${@bb.utils.contains('DISTRO_FEATURES', 'BuildFromTip', '${AUTOREV}', 'ce3170c9c8710a44b4627248e1443c31a9f7ad43', d)}"
