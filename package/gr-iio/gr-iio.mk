################################################################################
#
# gr-iio
#
################################################################################
GR_IIO_VERSION = d6d1f6ac7db5be3eb990ee8ef78bb65cf3a15dd7
GR_IIO_SITE = https://github.com/analogdevicesinc/gr-iio.git
GR_IIO_SITE_METHOD = git

GR_IIO_SUPPORTS_IN_SOURCE_BUILD = NO

GR_IIO_INSTALL_STAGING = YES
GR_IIO_LICENSE = LGPL-2.1+
GR_IIO_LICENSE_FILES = LICENSE
GR_IIO_DEPENDENCIES = libad9361-iio gnuradio

GR_IIO_CONF_OPTS = \
	-DENABLE_DOXYGEN=OFF

$(eval $(cmake-package))
