################################################################################
#
# libxtrxll
#
################################################################################

LIBXTRXLL_VERSION = 1b6eddfbedc700efb6f7e3c3594e43ac6ff29ea4
LIBXTRXLL_SITE = $(call github,xtrx-sdr,libxtrxll,$(LIBXTRXLL_VERSION))
LIBXTRXLL_LICENSE = LGPL-2.1+
LIBXTRXLL_LICENSE_FILES = LICENSE

# libxtrxll prevents doing an in-source-tree build
LIBXTRXLL_SUPPORTS_IN_SOURCE_BUILD = NO

LIBXTRXLL_CONF_OPTS = \
	-DENABLE_PCIE=ON \
	-DENABLE_USB3380=ON

ifeq ($(BR2_STATIC_LIBS),y)
	LIBXTRXLL_CONF_OPTS += -DXTRXLL_STATIC=ON
else
	LIBXTRXLL_CONF_OPTS += -DXTRXLL_STATIC=OFF
endif

# For third-party blocks, the libxtrxll libraries are mandatory at
# compile time.
LIBXTRXLL_INSTALL_STAGING = YES

$(eval $(cmake-package))
