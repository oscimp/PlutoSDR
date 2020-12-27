################################################################################
#
# librpitx
#
################################################################################
LIBRPITX_VERSION = master
LIBRPITX_SITE = $(call github,F5OEO,librpitx,$(LIBRPITX_VERSION))

LIBRPITX_INSTALL_STAGING = YES
LIBRPITX_LICENSE = GPL-3.0
LIBRPITX_LICENSE_FILES = GNU_General_Public_License.txt

define LIBRPITX_CONFIGURE_CMDS
	echo "CFLAGS=-g -O3 -std=c++11 -I /opt/vc/include " > $(LIBRPITX_DIR)/src/config.mk
	echo "LDFLAGS= -lm -lrt -lpthread -L/opt/vc/lib -lbcm_host " >> $(LIBRPITX_DIR)/src/config.mk
	echo "INSTALL=install" >> $(LIBRPITX_DIR)/src/config.mk
	echo "MAKE=make" >> $(LIBRPITX_DIR)/src/config.mk
	echo "prefix=/usr" >> $(LIBRPITX_DIR)/src/config.mk
	echo "SOVERSION=1" >> $(LIBRPITX_DIR)/src/config.mk
endef

define LIBRPITX_BUILD_CMDS
    $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D)/src
endef

define LIBRPITX_INSTALL_STAGING_CMDS
	$(INSTALL) -D -m 0755 $(@D)/src/librpitx.a $(STAGING_DIR)/usr/lib/librpitx.a
endef

define LIBRPITX_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/src/librpitx.a $(STAGING_DIR)/usr/lib/librpitx.a
endef

$(eval $(generic-package))
