RDEPENDS_packagegroup-rdk-ccsp-broadband_append = " crashupload"
RDEPENDS_packagegroup-rdk-ccsp-broadband_append = " rdk-wps-monitor"
RDEPENDS_packagegroup-rdk-ccsp-broadband_append = "${@bb.utils.contains('DISTRO_FEATURES', 'EasyMesh',' unified-wifi-mesh unified-wifi-mesh-cli ','',d)}"
RDEPENDS_packagegroup-rdk-ccsp-broadband_append = "${@bb.utils.contains('DISTRO_FEATURES', 'with_alsap',' ieee1905-em ','',d)}"
