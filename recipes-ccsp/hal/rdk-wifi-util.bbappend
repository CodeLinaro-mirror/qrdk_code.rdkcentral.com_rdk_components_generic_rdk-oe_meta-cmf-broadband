# Add flags to support mesh wifi if the feature is available.
CFLAGS:append = " ${@bb.utils.contains('DISTRO_FEATURES', 'meshwifi', '-DENABLE_FEATURE_MESHWIFI', '', d)}"

inherit coverity
