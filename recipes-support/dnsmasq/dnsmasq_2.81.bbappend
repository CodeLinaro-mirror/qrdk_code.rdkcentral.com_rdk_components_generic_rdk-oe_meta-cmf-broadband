FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:remove = " \
			file://dnsmasq-2.81-XDNS-secondary-XDNS-feature-zombie-fix.patch \
			file://dnsmasq-2.81-XDNS-log-protect-browsing-MultiProfile.patch \
		"

SRC_URI:append = " \
			file://dnsmasq-2.81-Updated-XDNS-secondary-XDNS-feature-zombie-fix.patch \
			file://dnsmasq-2.81-Updated-XDNS-log-protect-browsing-MultiProfile.patch  \
"
