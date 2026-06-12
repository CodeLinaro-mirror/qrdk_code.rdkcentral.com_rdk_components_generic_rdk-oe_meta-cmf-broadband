RDEPENDS:packagegroup-rdk-oss-broadband:append = " \
      ${@bb.utils.contains('DISTRO_FEATURES', 'enable_debug_tool', 'valgrind', '', d)} \
"
