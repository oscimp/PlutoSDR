################################################################################
#
# Patch the linux kernel with xtrx_linux_pcie_drv extension
#
################################################################################

LINUX_EXTENSIONS += xtrx_linux_pcie_drv

# for linux >= 3.15 install to drivers/video/fbdev/xtrx_linux_pcie_drv
# for linux < 3.15 install to drivers/video/xtrx_linux_pcie_drv
define XTRX_LINUX_PCIE_DRV_PREPARE_KERNEL
	dest=drivers/media/radio; \
	xtrx_dir=drivers/media/radio/xtrx_linux_pcie_drv; \
	mkdir -p $(LINUX_DIR)/$${dest}/xtrx_linux_pcie_drv; \
	cp -dpfr $(XTRX_LINUX_PCIE_DRV_DIR)/* $(LINUX_DIR)/$${dest}/xtrx_linux_pcie_drv/ ; \
	echo "source \"$${dest}/xtrx_linux_pcie_drv/Kconfig\"" \
		>> $(LINUX_DIR)/$${dest}/Kconfig ; \
	echo 'obj-y += xtrx_linux_pcie_drv/' >> $(LINUX_DIR)/$${dest}/Makefile ; \
	echo "config XTRX_LINUX_PCIE_DRV" >> $(LINUX_DIR)/$${xtrx_dir}/Kconfig ; \
	echo -e "\ttristate \"XTRX PCI driver for linux\"" >> $(LINUX_DIR)/$${xtrx_dir}/Kconfig ; \
	echo -e "\tdepends on PCI" >> $(LINUX_DIR)/$${xtrx_dir}/Kconfig ; \
	echo -e "\tdefault m" >> $(LINUX_DIR)/$${xtrx_dir}/Kconfig ; \
	echo -e "\thelp" >> $(LINUX_DIR)/$${xtrx_dir}/Kconfig ; \
	echo -e "\t  Say Y to enable XTRX PCI driver" >> $(LINUX_DIR)/$${xtrx_dir}/Kconfig ; \
	echo 'obj-$$(CONFIG_XTRX_LINUX_PCIE_DRV) += xtrx.o' >> $(LINUX_DIR)/$${xtrx_dir}/Makefile
endef
