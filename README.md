# PlutoSDR
BR2_EXTERNAL framework for Analog Device's PlutoSDR Zynq

This repository provides buildroot based support for ADALM-pluto board (based on
[Analog Device's plutosdr-fw](https://github.com/analogdevicesinc/plutosdr-fw)).

At the moment, this repository provides only support for rootfs and linux (the bootloader
part still remains to be added).

It uses the BR2_EXTERNAL mecanism to add this support in buildroot.

This support has been tested with the latest stable release of buildroot (2018.11.1).

How-to use it
=============

Download the latest tested buildroot tarball:
```bash
wget https://buildroot.org/downloads/buildroot-2018.11.1.tar.gz
```

Adding support for the PlutoSDR requires sourcing the **sourceme.ggm** file to add the **BR2_EXTERNAL** 
variable definition (alternatively, one might want to add <code>export
BR2_EXTERNAL=/somewhere/PlutoSDR</code> to the *.bashrc* initialization file).

In the buildroot directory  
```bash
make zynq_pluto_defconfig
```
will configure buildroot for PlutoSDR support. <code>make menuconfig</code> allows for configuring
additional settings of the buildroot environment, especially Target Packages, <code>make</code> builds
the images to be found at the end of the compilation in <code>output/images</code>.
