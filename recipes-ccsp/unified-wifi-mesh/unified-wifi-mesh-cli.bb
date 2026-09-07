SUMMARY = "Unified-wifi-mesh for cli "
HOMEPAGE = "http://github.com/rdkcentral/unified-wifi-mesh"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${S}/src/import/LICENSE;md5=e0b1ae637439c7d6f4487fb90163c79a"

SRC_URI = "${@bb.utils.contains('DISTRO_FEATURES', 'BuildFromTip', 'git://github.com/rdkcentral/unified-wifi-mesh.git;branch=develop;protocol=https;name=Unified-wifi-mesh-cli', 'git://github.com/rdkcentral/unified-wifi-mesh.git;nobranch=1;protocol=https;name=Unified-wifi-mesh-cli', d)}"
PV_Unified-wifi-mesh = "v0.3.1"
#SRCREV_Unified-wifi-mesh-cli = "${@bb.utils.contains('DISTRO_FEATURES', 'BuildFromTip', '${AUTOREV}', 'c0e72a31c96cc63cc366fcf2b628132185985d2a', d)}"

SRCREV_FIXED = "c0e72a31c96cc63cc366fcf2b628132185985d2a"

python __anonymous() {
    if bb.utils.contains('DISTRO_FEATURES', 'BuildFromTip', True, False, d):
        d.setVar('SRCREV_Unified-wifi-mesh-cli', '${AUTOREV}')
    else:
        d.setVar('SRCREV_Unified-wifi-mesh-cli', d.getVar('SRCREV_FIXED'))
}
SRCREV_FORMAT = "Unified-wifi-mesh-cli"

GO_IMPORT = "import"


inherit goarch
inherit go

DEPENDS = " readline ccsp-one-wifi ccsp-one-wifi-libwebconfig unified-wifi-mesh-header unified-wifi-mesh go "
RDEPENDS:${PN} = " unified-wifi-mesh"

EXTRA_OEMAKE = "GO='${GO}'"

CFLAGS:append = " \
    -I${STAGING_INCDIR} \
    -I${STAGING_INCDIR}/ccsp \
    -I=${includedir}/rbus \ 
"
CFLAGS:append = " -g -DEASY_MESH_NODE -DEM_APP -fPIC "

LDFLAGS:append = " -lemcli "

do_fetch_mod () {
	export GOPATH="${S}"
	cd ${S}/src/import/src/rdkb-cli
	go get -a
}
do_fetch_mod[network] = "1"

addtask fetch_mod after do_unpack do_prepare_recipe_sysroot before do_configure

do_compile() {
	export GOARCH="${TARGET_GOARCH}"
	export GOROOT="${STAGING_LIBDIR}/go"

	export GOPATH="${S}"

	# Pass the needed cflags/ldflags so that cgo
	# can find the needed headers files and libraries
	export CGO_ENABLED="1"
	export CFLAGS=""
	export LDFLAGS=""
	export CGO_CFLAGS="${TARGET_CFLAGS} ${CFLAGS}"
	export CGO_LDFLAGS="${TARGET_LDFLAGS} ${LDFLAGS}"
 
	cd ${S}/src/import/src/rdkb-cli
	oe_runmake build 
	cd -
	# For clean task
	chmod -R u+w ${S}/pkg
}

do_install() {
        install -d ${D}/usr/bin
        install -d ${D}/usr/ccsp/EasyMesh/static
        install -m 755 ${S}/src/import/src/rdkb-cli/onewifi_em_cli  ${D}/usr/bin
        cp -rf ${S}/src/import/src/rdkb-cli/static/*  ${D}/usr/ccsp/EasyMesh/static
}

FILES:${PN} += " ${bindir}/* /usr/ccsp/EasyMesh/static/* "
