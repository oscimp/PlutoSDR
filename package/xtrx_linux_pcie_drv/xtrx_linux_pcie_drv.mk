################################################################################
#
# xtrx_linux_pcie_drv
#
################################################################################

XTRX_LINUX_PCIE_DRV_VERSION = 5ae3a3e877e5b04da6e1cfdcca2d2f124857ddb0
XTRX_LINUX_PCIE_DRV_SITE = $(call github,xtrx-sdr,xtrx_linux_pcie_drv,$(XTRX_LINUX_PCIE_DRV_VERSION))
XTRX_LINUX_PCIE_DRV_LICENSE = GPL-2.0
XTRX_LINUX_PCIE_DRV_LICENSE_FILES = xtrx.c

$(eval $(generic-package))
