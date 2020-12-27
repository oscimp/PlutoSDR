################################################################################
#
# librpitx
#
################################################################################
LIBFT8_VERSION = master
LIBFT8_SITE = $(call github,kgoba,ft8_lib,$(LIBFT8_VERSION))

LIBFT8_INSTALL_STAGING = YES
LIBFT8_LICENSE = GPL-3.0
LIBFT8_LICENSE_FILES = GNU_General_Public_License.txt

define LIBFT8_CONFIGURE_CMDS
	echo "CFLAGS=-g -O3 -std=c++11 -I /opt/vc/include " > $(LIBFT8_DIR)/config.mk
	echo "LDFLAGS= -lm -lrt -lpthread -L/opt/vc/lib -lbcm_host " >> $(LIBFT8_DIR)/config.mk
	echo "INSTALL=install" >> $(LIBFT8_DIR)/config.mk
	echo "MAKE=make" >> $(LIBFT8_DIR)/config.mk
	echo "prefix=/usr" >> $(LIBFT8_DIR)/config.mk
	echo "SOVERSION=1" >> $(LIBFT8_DIR)/config.mk
endef

define LIBFT8_BUILD_CMDS
    $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D)
endef

define LIBFT8_INSTALL_STAGING_CMDS
	$(INSTALL) -D -m 0755 $(@D)/libft8.a $(STAGING_DIR)/usr/lib/libft8.a
	mkdir -p $(STAGING_DIR)/usr/include/ft8
	$(INSTALL) -D -m 0755 $(@D)/ft8/*.h $(STAGING_DIR)/usr/include/ft8/
	$(INSTALL) -D -m 0755 $(@D)/common/wave.h $(STAGING_DIR)/usr/include/ft8/
endef

define LIBFT8_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/libft8.a $(STAGING_DIR)/usr/lib/libft8.a
endef

$(eval $(generic-package))
