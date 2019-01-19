# PlutoSDR
BR2_EXTERNAL framework for Analog Device's PlutoSDR Zynq

This repository provides buildroot based support for ADALM-pluto board (based on
analogdevice plutosdr-fw).

Currently this repository provides only support for rootfs and linux (bootloader
part must be added).

It uses the BR2_EXTERNAL mecanism to add this support in buildroot.

This support has been tested with the latest stable release of buildroot (2018.11.1).

How-to use it
=============

You need to download corresponding tarball:
```bash
wget https://buildroot.org/downloads/buildroot-2018.11.1.tar.gz
```

To add the support you need to source **sourceme.ggm** file to add **BR2_EXTERNAL** to
your env (it's possible to add <code>export
BR2_EXTERNAL=/somewhere/PlutoSDR</code> in *.bashrc*).

Now, in buildroot directory you can use 
```bash
make zynq_pluto_defconfig
```
to configure buildroot
