################################################################################
#
# gr-iio
#
################################################################################
GR_IIO_VERSION = e9d12b559c3efa085304fffba4a4310bb1297367
GR_IIO_SITE = https://github.com/analogdevicesinc/gr-iio.git
GR_IIO_SITE_METHOD = git

GR_IIO_INSTALL_STAGING = YES
GR_IIO_LICENSE = LGPL-2.1+
GR_IIO_LICENSE_FILES = LICENSE
GR_IIO_DEPENDENCIES = libad9361-iio gnuradio

$(eval $(cmake-package))
