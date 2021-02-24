################################################################################
#
# rpitx
#
################################################################################
RPITX_VERSION = cce1fe6acf90d4d34ce304aed48fe80ec4ff51e7
RPITX_SITE = $(call github,F5OEO,rpitx,$(RPITX_VERSION))

RPITX_INSTALL_STAGING = YES
RPITX_LICENSE = GPL-3.0
RPITX_LICENSE_FILES = GNU_General_Public_License.txt
RPITX_DEPENDENCIES = libsndfile ft8_lib librpitx

define RPITX_BUILD_CMDS
    $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D)/src
endef

define RPITX_INSTALL_STAGING_CMDS
endef

define RPITX_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/foxhunt $(TARGET_DIR)/usr/bin
	$(INSTALL) -D -m 0755 $(@D)/freedv $(TARGET_DIR)/usr/bin
	$(INSTALL) -D -m 0755 $(@D)/rpitx $(TARGET_DIR)/usr/bin
	$(INSTALL) -D -m 0755 $(@D)/pi* $(TARGET_DIR)/usr/bin
	$(INSTALL) -D -m 0755 $(@D)/sendiq $(TARGET_DIR)/usr/bin
	$(INSTALL) -D -m 0755 $(@D)/sendook $(TARGET_DIR)/usr/bin
	$(INSTALL) -D -m 0755 $(@D)/spectrumpaint $(TARGET_DIR)/usr/bin
	$(INSTALL) -D -m 0755 $(@D)/tune $(TARGET_DIR)/usr/bin
endef

$(eval $(generic-package))
