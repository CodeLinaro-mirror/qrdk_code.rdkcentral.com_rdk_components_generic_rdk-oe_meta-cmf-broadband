# Add flags to support mesh wifi if the feature is available.
CFLAGS_append = " ${@bb.utils.contains('DISTRO_FEATURES', 'meshwifi', '-DENABLE_FEATURE_MESHWIFI', '', d)}"

inherit coverity

SRC_URI_remove = "git://github.com/rdkcentral/rdk-wifi-hal.git;protocol=https;branch=main;name=rdk-wifi-util"

SRC_URI = "${@bb.utils.contains('DISTRO_FEATURES', 'BuildFromTip', 'git://github.com/rdkcentral/rdk-wifi-hal.git;protocol=https;branch=develop;name=rdk-wifi-util', 'git://github.com/rdkcentral/rdk-wifi-hal.git;protocol=https;nobranch=1;name=rdk-wifi-util', d)}"
SRCREV_rdk-wifi-util = "${@bb.utils.contains('DISTRO_FEATURES', 'BuildFromTip', '${AUTOREV}', 'b5e993135436885962f0c3535229e7ad5371ae80', d)}"
