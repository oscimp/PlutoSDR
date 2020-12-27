################################################################################
#
# rpitx
#
################################################################################
RPITX_VERSION = master
RPITX_SITE = $(call github,F5OEO,rpitx,$(RPITX_VERSION))

RPITX_INSTALL_STAGING = YES
RPITX_LICENSE = GPL-3.0
RPITX_LICENSE_FILES = GNU_General_Public_License.txt

define RPITX_CONFIGURE_CMDS
	echo "CFLAGS=-g -O3 -std=c++11 -I /opt/vc/include " > $(RPITX_DIR)/src/config.mk
	echo "LDFLAGS= -lm -lrt -lpthread -L/opt/vc/lib -lbcm_host " >> $(RPITX_DIR)/src/config.mk
	echo "INSTALL=install" >> $(RPITX_DIR)/src/config.mk
	echo "MAKE=make" >> $(RPITX_DIR)/src/config.mk
	echo "prefix=/usr" >> $(RPITX_DIR)/src/config.mk
	echo "SOVERSION=1" >> $(RPITX_DIR)/src/config.mk
endef

define RPITX_BUILD_CMDS
    $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D)/src
endef

define RPITX_INSTALL_STAGING_CMDS
    $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) \
        DESTDIR=$(STAGING_DIR) -C $(@D) install
endef

define RPITX_INSTALL_TARGET_CMDS
    $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) \
        DESTDIR=$(TARGET_DIR) -C $(@D) install
endef

$(eval $(generic-package))
