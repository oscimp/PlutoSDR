################################################################################
#
# liblms7002m
#
################################################################################

LIBLMS7002M_VERSION = b07761b7386181f0e6a35158456b75bce14f2aca
LIBLMS7002M_SITE = $(call github,xtrx-sdr,liblms7002m,$(LIBLMS7002M_VERSION))
LIBLMS7002M_LICENSE = LGPL-2.1+
LIBLMS7002M_LICENSE_FILES = LICENSE

# liblms7002m prevents doing an in-source-tree build
LIBLMS7002M_SUPPORTS_IN_SOURCE_BUILD = NO

LIBLMS7002M_DEPENDENCIES = host-python3 host-python3-cheetah

# For third-party blocks, the liblms7002m libraries are mandatory at
# compile time.
LIBLMS7002M_INSTALL_STAGING = YES

$(eval $(cmake-package))
