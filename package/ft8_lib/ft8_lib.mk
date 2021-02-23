################################################################################
#
# librpitx
#
################################################################################
FT8_LIB_VERSION = 6ebf14342e77cdd378b89934c31df4b3cd208c2b
FT8_LIB_SITE = $(call github,kgoba,ft8_lib,$(FT8_LIB_VERSION))

FT8_LIB_INSTALL_STAGING = YES
FT8_LIB_LICENSE = GPL-3.0
FT8_LIB_LICENSE_FILES = GNU_General_Public_License.txt

define FT8_LIB_BUILD_CMDS
    $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D)
endef

define FT8_LIB_INSTALL_STAGING_CMDS
	$(INSTALL) -D -m 0755 $(@D)/libft8.so $(STAGING_DIR)/usr/lib/libft8.so
	mkdir -p $(STAGING_DIR)/usr/include/ft8_lib/common
	mkdir -p $(STAGING_DIR)/usr/include/ft8_lib/ft8
	mkdir -p $(STAGING_DIR)/usr/include/ft8_lib/fft
	$(INSTALL) -D -m 0755 $(@D)/ft8/*.h $(STAGING_DIR)/usr/include/ft8_lib/ft8/
	$(INSTALL) -D -m 0755 $(@D)/common/*.h $(STAGING_DIR)/usr/include/ft8_lib/common/
	$(INSTALL) -D -m 0755 $(@D)/fft/*.h $(STAGING_DIR)/usr/include/ft8_lib/fft/
endef

define FT8_LIB_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/libft8.so $(STAGING_DIR)/usr/lib/libft8.so
endef

$(eval $(generic-package))
