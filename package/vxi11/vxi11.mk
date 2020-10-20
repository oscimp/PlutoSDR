################################################################################
#
# vxi11
#
################################################################################
VXI11_VERSION = 5d96ccfad4f6f58d7f3ec31c3eb3a0ee356036b8
VXI11_SITE = $(call github,applied-optics,vxi11,$(VXI11_VERSION))

VXI11_INSTALL_STAGING = YES
VXI11_LICENSE = LGPL-2.1+
VXI11_LICENSE_FILES = GNU_General_Public_License.txt

VXI11_DEPENDENCIES = libtirpc

VXI11_CFLAGS = $(TARGET_CFLAGS) `$(PKG_CONFIG_HOST_BINARY) --cflags libtirpc`
VXI11_LIBS = $(TARGET_LDFLAGS) `$(PKG_CONFIG_HOST_BINARY) --libs libtirpc`

define VXI11_CONFIGURE_CMDS
	echo "CFLAGS=-g $(VXI11_CFLAGS)" > $(VXI11_DIR)/config.mk
	echo "LDFLAGS=$(VXI11_LIBS)" >> $(VXI11_DIR)/config.mk
	echo "INSTALL=install" >> $(VXI11_DIR)/config.mk
	echo "MAKE=make" >> $(VXI11_DIR)/config.mk
	echo "prefix=/usr" >> $(VXI11_DIR)/config.mk
	echo "SOVERSION=1" >> $(VXI11_DIR)/config.mk
endef

define VXI11_BUILD_CMDS
    $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D)
endef

define VXI11_INSTALL_STAGING_CMDS
    $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) \
        DESTDIR=$(STAGING_DIR) -C $(@D) install
endef

define VXI11_INSTALL_TARGET_CMDS
    $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) \
        DESTDIR=$(TARGET_DIR) -C $(@D) install
endef

$(eval $(generic-package))
