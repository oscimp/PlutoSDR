################################################################################
#
# gnss-sdr
#
################################################################################

GNSS_SDR_VERSION = 0.0.12
GNSS_SDR_SITE = $(call github,gnss-sdr,gnss-sdr,v$(GNSS_SDR_VERSION))
GNSS_SDR_LICENSE = GPL-3.0+
GNSS_SDR_LICENSE_FILES = COPYING

# gnss-sdr prevents doing an in-source-tree build
GNSS_SDR_SUPPORTS_IN_SOURCE_BUILD = NO

GNSS_SDR_DEPENDENCIES = armadillo boost openssl clapack \
	gflags glog log4cpp gnuradio gnutls matio protobuf pugixml

GNSS_SDR_CONF_OPTS += \
	-DBUILD_SHARED_LIBS=OFF \
	-DENABLE_TESTING=OFF \
	-DENABLE_UNIT_TESTING=OFF \
	-DENABLE_DEFAULT=OFF \
	-DENABLE_DOXYGEN=OFF \
	-DENABLE_LOG=OFF

ifeq ($(BR2_PACKAGE_ORC),y)
GNSS_SDR_DEPENDENCIES += orc
endif

ifeq ($(BR2_PACKAGE_GNSS_SDR_AD9361),y)
GNSS_SDR_CONF_OPTS += -DENABLE_AD9361=ON
GNSS_SDR_DEPENDENCIES += libiio-pluto
else
GNSS_SDR_CONF_OPTS += -DENABLE_AD9361=OFF
endif

ifeq ($(BR2_PACKAGE_GNSS_SDR_OSMOSDR),y)
GNSS_SDR_CONF_OPTS += -DENABLE_OSMOSDR=ON
GNSS_SDR_DEPENDENCIES += gr-osmosdr
else
GNSS_SDR_CONF_OPTS += -DENABLE_OSMOSDR=OFF
endif

ifeq ($(BR2_PACKAGE_GNSS_SDR_UHD),y)
GNSS_SDR_CONF_OPTS += -DENABLE_UHD=ON
GNSS_SDR_DEPENDENCIES += uhd
else
GNSS_SDR_CONF_OPTS += -DENABLE_UHD=OFF
endif

ifeq ($(BR2_PACKAGE_GNSS_SDR_PLUTOSDR),y)
GNSS_SDR_CONF_OPTS += -DENABLE_PLUTOSDR=ON
GNSS_SDR_DEPENDENCIES += gr-iio
else
GNSS_SDR_CONF_OPTS += -DENABLE_PLUTOSDR=OFF
endif

$(eval $(cmake-package))
