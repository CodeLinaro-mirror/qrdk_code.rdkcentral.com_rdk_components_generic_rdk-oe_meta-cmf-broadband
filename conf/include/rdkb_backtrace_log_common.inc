#breakpad support
BACKTRACE_DEPENDS:pn-unified-wifi-mesh = " breakpad-wrapper"
BACKTRACE_DEPENDS:pn-ieee1905-em = " breakpad-wrapper"

BACKTRACE_LDFLAGS:pn-unified-wifi-mesh = " -Wl,--no-as-needed -lbreakpadwrapper -Wl,--as-needed "
BACKTRACE_LDFLAGS:pn-ieee1905-em = " -Wl,--no-as-needed -lbreakpadwrapper -Wl,--as-needed "
