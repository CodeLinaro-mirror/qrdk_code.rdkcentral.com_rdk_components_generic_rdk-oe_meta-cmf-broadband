BBMASK .= "|meta-rdk-broadband/recipes-ccsp/ccsp/rdk-easymesh-controller.bb"
BBMASK .= "|meta-rdk-broadband/recipes-extended/hwselftest/"
BBMASK .= "|meta-rdk-broadband/recipes-rdkb/sysint-broadband/sysint-broadband-min.bb"

BBMASK .= "|meta-rdk/recipes-common/nlmonitor/"
BBMASK .= "|meta-rdk/recipes-connectivity/bluetooth/"

# Use the default jansson recipe in meta-openembedded
BBMASK .= "|meta-rdk-ext/recipes-support/jansson/"

BBMASK .= "|meta-cmf-raspberrypi/recipes-extended/wifi-client-hal/"

BBMASK .= "|meta-cmf/recipes-extended/rpcserver/"

# Yocto-6.0 Change
BBMASK .= "|meta-rdk-broadband/recipes-ccsp/ccsp/ccsp-webui-jst-onestack.bbappend"
BBMASK .= "|meta-rdk-broadband-apps/recipes-kernel/linux/rpi-cmdline.bbappend"
BBMASK .= "|meta-cmf-filogic/recipes-ccsp/ccsp/rdk-easymesh-controller.bbappend"
BBMASK .= "|meta-cmf-bananapi/meta-rdk-mtk-bpir4/recipes-wifi/hal/hal-wifi-mt76.bbappend"

