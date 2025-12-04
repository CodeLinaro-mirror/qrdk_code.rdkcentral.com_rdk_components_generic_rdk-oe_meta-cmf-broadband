LDFLAGS += " -lpthread"

TARGET_CFLAGS += "-Wno-error=address"
INSANE_SKIP:${PN} += "dev-so"
