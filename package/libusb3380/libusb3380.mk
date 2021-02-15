################################################################################
#
# libusb3380
#
################################################################################

LIBUSB3380_VERSION = c83d1e93eb3a5b8b6a9db41c2613b206f344f825
LIBUSB3380_SITE = $(call github,xtrx-sdr,libusb3380,$(LIBUSB3380_VERSION))
LIBUSB3380_LICENSE = LGPL-2.1+
LIBUSB3380_LICENSE_FILES = LICENSE

# libusb3380 prevents doing an in-source-tree build
LIBUSB3380_SUPPORTS_IN_SOURCE_BUILD = NO

LIBUSB3380_DEPENDENCIES = host-python3 host-python3-cheetah

# For third-party blocks, the libusb3380 libraries are mandatory at
# compile time.
LIBUSB3380_INSTALL_STAGING = YES

$(eval $(cmake-package))
