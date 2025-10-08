DEPENDS += "breakpad breakpad-wrapper"

CFLAGS += "-I${STAGING_INCDIR}/breakpad "
CXXFLAGS += "-I${STAGING_INCDIR}/breakpad "

LDFLAGS += "-lbreakpadwrapper -lpthread -lsyscfg"

TARGET_CFLAGS += "-Wno-implicit-function-declaration"
