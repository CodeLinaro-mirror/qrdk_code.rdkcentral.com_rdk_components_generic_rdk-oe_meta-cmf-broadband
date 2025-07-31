inherit coverity

DEPENDS:append = " protobuf-c"
RDEPENDS_${PN}:append = " openvswitch"
LDFLAGS:remove = " -ldpp"
