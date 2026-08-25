LICENSE = "GPL-2.0-or-later"
LIC_FILES_CHKSUM = "file://COPYING;md5=b234ee4d69f5fce4486a80fdaf4a4263"

require pjproject.inc

SRCREV = "9244fb0f0015d08db1b0d29e49d118f084fab097"

SRC_URI += "\
    file://arm-arch.patch \
    file://install-perms.patch \
\
    file://0100-allow_multiple_auth_headers.patch \
    file://0200-potential-buffer-overflow-in-pjlib-scanner-and-pjmedia.patch \
    file://0201-potential-stack-buffer-overflow-when-parsing-message-as-a-STUN-client.patch \
"
