################################################################################
#
# libxtrx
#
################################################################################

LIBXTRX_VERSION = acb0b1cf7ab92744034767a04c1d4b4c281b840f
LIBXTRX_SITE = $(call github,xtrx-sdr,libxtrx,$(LIBXTRX_VERSION))
LIBXTRX_LICENSE = LGPL-2.1+
LIBXTRX_LICENSE_FILES = LICENSE

LIBXTRX_DEPENDENCIES = liblms7002m libxtrxll libxtrxdsp

# libxtrx prevents doing an in-source-tree build
LIBXTRX_SUPPORTS_IN_SOURCE_BUILD = NO

LIBXTRX_CONF_OPTS = \
	-DENABLE_SOAPY=OFF \
	-DENABLE_USB3380=OFF

ifeq ($(BR2_STATIC_LIBS),y)
	LIBXTRX_CONF_OPTS += -DXTRXLL_STATIC=ON
else
	LIBXTRX_CONF_OPTS += -DXTRXLL_STATIC=OFF
endif

# For third-party blocks, the libxtrx libraries are mandatory at
# compile time.
LIBXTRX_INSTALL_STAGING = YES

$(eval $(cmake-package))
