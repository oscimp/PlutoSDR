################################################################################
#
# matio
#
################################################################################

MATIO_VERSION = 1.5.17
MATIO_SITE = http://downloads.sourceforge.net/project/matio/matio/$(MATIO_VERSION)
MATIO_LICENSE = BSD-2-Clause
MATIO_LICENSE_FILES = COPYING

MATIO_DEPENDENCIES = zlib

# For third-party blocks, the matio libraries are mandatory at
# compile time.
MATIO_INSTALL_STAGING = YES

# va_copy()
MATIO_CONF_ENV += ac_cv_va_copy=yes

MATIO_CONF_OPTS = --enable-mat73=no

ifeq ($(BR2_PACKAGE_MATIO_SPARSE),y)
MATIO_CONF_OPTS += --enable-extended-sparse=yes
else
MATIO_CONF_OPTS += --enable-extended-sparse=no
endif

$(eval $(autotools-package))
