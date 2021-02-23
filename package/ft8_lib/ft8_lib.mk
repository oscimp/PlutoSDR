################################################################################
#
# librpitx
#
################################################################################
LIBFT8_VERSION = 6ebf14342e77cdd378b89934c31df4b3cd208c2b
LIBFT8_SITE = $(call github,kgoba,ft8_lib,$(LIBFT8_VERSION))

LIBFT8_INSTALL_STAGING = YES
LIBFT8_LICENSE = GPL-3.0
LIBFT8_LICENSE_FILES = GNU_General_Public_License.txt

define LIBFT8_BUILD_CMDS
    $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D)
endef

define LIBFT8_INSTALL_STAGING_CMDS
	$(INSTALL) -D -m 0755 $(@D)/libft8.so $(STAGING_DIR)/usr/lib/libft8.so
	mkdir -p $(STAGING_DIR)/usr/include/ft8_lib/common
	mkdir -p $(STAGING_DIR)/usr/include/ft8_lib/ft8
	mkdir -p $(STAGING_DIR)/usr/include/ft8_lib/fft
	$(INSTALL) -D -m 0755 $(@D)/ft8/*.h $(STAGING_DIR)/usr/include/ft8_lib/ft8/
	$(INSTALL) -D -m 0755 $(@D)/common/*.h $(STAGING_DIR)/usr/include/ft8_lib/common/
	$(INSTALL) -D -m 0755 $(@D)/fft/*.h $(STAGING_DIR)/usr/include/ft8_lib/fft/
endef

define LIBFT8_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/libft8.so $(STAGING_DIR)/usr/lib/libft8.so
endef

$(eval $(generic-package))
