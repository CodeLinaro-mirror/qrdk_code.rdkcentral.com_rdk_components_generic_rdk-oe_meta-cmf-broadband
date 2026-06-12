CFLAGS += "-DENABLE_PLUGIN_SIMTECH"

do_install:append() {
   install ${WORKDIR}/build/plugins/libmm-plugin-simtech.so ${D}/usr/lib/ModemManager/.
}

