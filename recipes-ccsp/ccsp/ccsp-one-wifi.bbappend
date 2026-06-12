inherit coverity

DEPENDS:append = " protobuf-c"
RDEPENDS:${PN}:append = " openvswitch"
LDFLAGS:remove = " -ldpp"
