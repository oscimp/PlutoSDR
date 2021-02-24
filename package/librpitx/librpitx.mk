################################################################################
#
# librpitx
#
################################################################################
LIBRPITX_VERSION = b0172f908be0d8a8990c15dd246f1e630823d9d4
LIBRPITX_SITE = $(call github,F5OEO,librpitx,$(LIBRPITX_VERSION))

LIBRPITX_INSTALL_STAGING = YES
LIBRPITX_LICENSE = GPL-3.0
LIBRPITX_LICENSE_FILES = GNU_General_Public_License.txt

define LIBRPITX_BUILD_CMDS
    $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D)/src
endef

define LIBRPITX_INSTALL_STAGING_CMDS
	$(INSTALL) -D -m 0644 $(@D)/src/librpitx.so $(STAGING_DIR)/usr/lib/librpitx.so
	mkdir -p $(STAGING_DIR)/usr/include/librpitx
	$(INSTALL) -D -m 0644 $(@D)/src/librpitx.h $(STAGING_DIR)/usr/include/librpitx/librpitx.h
	$(INSTALL) -D -m 0644 $(@D)/src/dma.h $(STAGING_DIR)/usr/include/librpitx/dma.h
	$(INSTALL) -D -m 0644 $(@D)/src/gpio.h $(STAGING_DIR)/usr/include/librpitx/gpio.h
	$(INSTALL) -D -m 0644 $(@D)/src/util.h $(STAGING_DIR)/usr/include/librpitx/util.h
	$(INSTALL) -D -m 0644 $(@D)/src/dsp.h $(STAGING_DIR)/usr/include/librpitx/dsp.h
	$(INSTALL) -D -m 0644 $(@D)/src/atv.h $(STAGING_DIR)/usr/include/librpitx/atv.h
	$(INSTALL) -D -m 0644 $(@D)/src/mailbox.h $(STAGING_DIR)/usr/include/librpitx/mailbox.h
	$(INSTALL) -D -m 0644 $(@D)/src/fmdmasync.h $(STAGING_DIR)/usr/include/librpitx/fmdmasync.h
	$(INSTALL) -D -m 0644 $(@D)/src/fskburst.h $(STAGING_DIR)/usr/include/librpitx/fskburst.h
	$(INSTALL) -D -m 0644 $(@D)/src/amdmasync.h $(STAGING_DIR)/usr/include/librpitx/amdmasync.h
	$(INSTALL) -D -m 0644 $(@D)/src/iqdmasync.h $(STAGING_DIR)/usr/include/librpitx/iqdmasync.h
	$(INSTALL) -D -m 0644 $(@D)/src/ngfmdmasync.h $(STAGING_DIR)/usr/include/librpitx/ngfmdmasync.h
	$(INSTALL) -D -m 0644 $(@D)/src/ookburst.h $(STAGING_DIR)/usr/include/librpitx/ookburst.h
	$(INSTALL) -D -m 0644 $(@D)/src/phasedmasync.h $(STAGING_DIR)/usr/include/librpitx/phasedmasync.h
	$(INSTALL) -D -m 0644 $(@D)/src/raspberry_pi_revision.h $(STAGING_DIR)/usr/include/librpitx/raspberry_pi_revision.h
	$(INSTALL) -D -m 0644 $(@D)/src/rpi.h $(STAGING_DIR)/usr/include/librpitx/rpi.h
	$(INSTALL) -D -m 0644 $(@D)/src/serialdmasync.h $(STAGING_DIR)/usr/include/librpitx/serialdmasync.h
endef

define LIBRPITX_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0644 $(@D)/src/librpitx.so $(TARGET_DIR)/usr/lib/librpitx.so
endef

$(eval $(generic-package))
