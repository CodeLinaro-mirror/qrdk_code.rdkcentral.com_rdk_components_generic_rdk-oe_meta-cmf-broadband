CFLAGS:append  += " ${@bb.utils.contains('DISTRO_FEATURES', 'rdkb_cellular_manager_mm', ' -DFEATURE_RDKB_CELLULAR_MANAGER', '', d)}"

do_install:append_class-target () {
         DISTRO_OneWiFi_ENABLED="${@bb.utils.contains('DISTRO_FEATURES','OneWifi','true','false',d)}"
         if [ $DISTRO_OneWiFi_ENABLED = 'false' ]; then
    	       install -D -m 0644 ${S}/systemd_units/ccspwifiagent.service ${D}${systemd_unitdir}/system/ccspwifiagent.service
	       sed -i "s/ExecStart=\/usr\/bin\/CcspWifiSsp -subsys \$Subsys/ExecStart=\/bin\/sh -c '\/usr\/bin\/CcspWifiSsp -subsys \$Subsys 2\&\>\/rdklogs\/logs\/wifihal.log'/g" ${D}/lib/systemd/system/ccspwifiagent.service
         fi 
}

do_install:append () {
    install -d ${D}${libdir}
    cp ${B}/source/.libs/libccsp_common.so.0.0.0 ${D}${libdir}/
    
    ln -s libccsp_common.so.0.0.0 ${D}${libdir}/libccsp_common.so.0
    ln -s libccsp_common.so.0.0.0 ${D}${libdir}/libccsp_common.so
}

TARGET_LDFLAGS:append += "-L${STAGING_LIBDIR}"

FILES:${PN}-dev += " \
    ${libdir}/libccsp_common.so \
"

