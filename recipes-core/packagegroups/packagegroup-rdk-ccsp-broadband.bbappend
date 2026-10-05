RDEPENDS:packagegroup-rdk-ccsp-broadband:append = " crashupload"
RDEPENDS:packagegroup-rdk-ccsp-broadband:append = " rdk-wps-monitor"
RDEPENDS:packagegroup-rdk-ccsp-broadband:append = "${@bb.utils.contains('DISTRO_FEATURES', 'EasyMesh',' unified-wifi-mesh unified-wifi-mesh-cli ','',d)}"
RDEPENDS:packagegroup-rdk-ccsp-broadband:append = "${@bb.utils.contains('DISTRO_FEATURES', 'with_alsap',' ieee1905-em ','',d)}"

# Remove Wi-Fi Experience Index, it is currently not buildable in OSS platforms
RDEPENDS:packagegroup-rdk-ccsp-broadband:remove = "wei"
