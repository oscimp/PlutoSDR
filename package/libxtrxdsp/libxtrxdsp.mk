################################################################################
#
# libxtrxdsp
#
################################################################################

LIBXTRXDSP_VERSION = eec28640c0ebd5639b642f07b310a0a0d02d9834
LIBXTRXDSP_SITE = $(call github,xtrx-sdr,libxtrxdsp,$(LIBXTRXDSP_VERSION))
LIBXTRXDSP_LICENSE = LGPL-2.1+
LIBXTRXDSP_LICENSE_FILES = LICENSE

# libxtrxdsp prevents doing an in-source-tree build
LIBXTRXDSP_SUPPORTS_IN_SOURCE_BUILD = NO

# For third-party blocks, the libxtrxdsp libraries are mandatory at
# compile time.
LIBXTRXDSP_INSTALL_STAGING = YES

$(eval $(cmake-package))
