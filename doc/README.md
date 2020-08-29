<span>**Buildroot for cross-compiling GNU Radio to embedded
boards**</span>  

The Raspberry Pi{3,4} (RPi) is a single board computer designed – for
the characteristics we are interested in for Software Defined Radio
applications – around a quad-core ARM processor clocked at 1.5 GHz with
1, 2 or 4 GB random access memory. The operating system is stored on a
microSD card and is hence easily updated from the host computer (never
<span>*ever*</span> compile on the target embedded board). Generating a
dedicated toolchain – as opposed to using a readily available binary
distribution – allows for optimizing instructions for the chipset
available on the targeted platform.

Our objective is to <span>**execute GNU Radio on the RPi**</span> in
order to run some pre-processing on the embedded board before sending
the processing result to the PC (e.g. receiving a broadcast FM station
on the RPi and send the audio output to the PC through a Zero-MQ link).

# Buildroot for RPi

Buildroot is a framework providing a consistent set of

  - cross-compilation toolchain for the host (usually Intel x86/AMD64
    processor)

  - libraries and userspace applications for the ARM target,

  - Linux kernel for the target,

  - bootloader for embedded target board initialization in order to load
    the Linux kernel in charge of supervizing userspace applications.

This consistency avoids many pitfalls when cross-compiling target
applications or kernel modules on the host. Obviously the
low-computational power target is <span>*not*</span> designed for
intensive computational load such as compiling GNU Radio, and
<span>gcc</span> should actually not even be available on the target,
neither is the SD card with its finite number of write cycles designed
for large compilation (at least make <span>/tmp/</span> a RAM filesystem
if trying such a compiltion on the target).

Installing the result of Buildroot cross-compilation on the Raspberry
Pi4 is described at
<https://github.com/buildroot/buildroot/tree/master/board/raspberrypi>
but the documentation on this web page is not up to date (?\!):

1.  <span>git clone https://git.busybox.net/buildroot</span>

2.  <span>cd buildroot</span>

3.  <span>make raspberrypi4\_64\_defconfig</span>

fetches the Buildroot archive, and configures for the RaspberryPi4 in
64 bit mode (obviously for RPi3, select
<span>raspberrypi3\_64\_defconfig</span>). Because Python support for
GNU Radio will require the <span>glibc</span> library rather than the
default <span>uClibc</span>, we must tune the default configuration

4.  <span>make menuconfig</span>

5.  Toolchain -> C library (uClibc-ng) -> glibc

6.  Exit

Once the proper C-library has been selected

7.  <span>make</span>

builds all tools needed for cross-compilation. This operation will take
about 40 min on an 8-core 2.33 GHz Xeon CPU with fast internet connexion
and require 7.4 GB of hard disk space. While compiling, Buildroot
<span>*only updates files stored*</span> in the <span>output</span>
directory. Thus, removing this directory (and sub-directories) will
return to the original Buildroot configuration. All software related to
the host computer – Intel x86/AMD64 architecture most of the time – is
located in <span>output/host</span>, while all software related to the
target (here ARM architecture) is stored in <span>output/target</span>.
We shall not be interested in the content of the directory in which
source files are stored but might have to erase some of its content to
force re-compilation: such files are stored in the
<span>output/build</span> directory. Finally, the last compilation stage
will result in a complete image including bootloader, kernel, libraries
and userspace applications: this file is stored in
<span>output/images</span>.

After completing buildroot compilation, we find in the
<span>output/images</span> directory the file <span>sdcard.img</span>
which holds the binary datastream (about 150 MB) to be stored on the
microSD card holding the operating system to be run on the RPi. Here,
“stored” doe not mean copying since we must clone each byte from the
binary file to the storage medium. Such an operation is achieved under
GNU/Linux with the Disk Dump <span>dd</span> command.

/!\ The following line might definitely <span>**corrupt a
hard disk**</span> if the wrong storage medium is selected. Alway
<span>**check**</span> the name of the peripheral associated with the SD
card (`dmesg | tail`) before running the <span>dd</span> command.

The image resulting from Buildroot compilation is transfered to the
microSD card with  

<div style="background-color: white">

sudo dd if=output/images/sdcard.img of=/dev/sdc

</div>

  
where we have on purpose selected the <span>/dev/sdc</span> peripheral
name in this example since it is ever hardly used. Usually, the microSD
card is accessed as <span>/dev/sdb</span> (second hard disk storage
medium compatible with the Linux SCSI driver) or
<span>/dev/mmcblk0</span> (internal SD medium interface).

In case a Desktop Manager or a File Manager is used, make sure the SD
card is unmounted before executing <span>dd</span>, as these tools will
interfere with the cloning process.

Once the image has been flashed on the SD card, we can see two
partitions: the first one is a VFAT (format compatible with Microsoft
Windows) with the devicetree, the Linux kernel and the bootloader, and a
second one holding the GNU/Linux userspace filesystem
(<span>rootfs</span>).

# Adding custom packages (GNU Radio and PlutoSDR/UHD

So far we have compiled a standard Buildroot image without dedicated GNU
Radio support. Dedicated packages not selected in the default
configuration can be activated. This is achieved from the Buildroot
directory with <span>make menuconfig</span> and selecting <span>Target
packages</span>. Searching (“/” command as in <span>vi</span>) allows
for quickly finding the appropriate package, such as GNU Radio.

Up to now we have only worked with “official” Buildroot packages
properly maintained by the Buildroot community. Some packages are not
yet integrated in the official repository but can nevertheless be
appended as external packages thanks to the <span>BR2\_EXTERNAL</span>
mechanism. As an example of supporting the PlutoSDR thanks to
<span>gr-iio</span>, this support is available thanks to the
<span>BR2\_EXTERNAL</span> repository found at
<https://github.com/oscimp/PlutoSDR> and most significantly its
<span>for\_next</span> branch. Hence, after going to any directory out
of the Buildroot source tree:

1.  `git clone https://github.com/oscimp/PlutoSDR`

2.  `cd PlutoSDR`

3.  `git checkout for_next`

4.  `source sourceme.ggm`

Now that the <span>BR2\_EXTERNAL</span> has been cloned, the appropriate
branch selected, and the environment variables set (last command),
return in the Buildroot directory and <span>make menuconfig</span>.
Running <span>make menuconfig</span> will now show a new menu named
<span>External options</span> including <span>gr-iio</span>,
<span>libuhd</span> or <span>gnss-sdr</span>.

1.  `make menuconfig`

2.  `/eudev`

3.  Select the last item indicating
    <span>BR2\_ROOTFS\_DEVICE\_CREATION\_DYNAMIC\_EUDEV</span> and
    replace <span>/dev management</span> with <span>Dynamic using
    devtmpfs + eudev</span>

4.  `/python3`

5.  Select item (4) indicating <span>BR2\_PACKAGE\_PYTHON3</span>

6.  `/gnuradio`

7.  Select item (1) indicating <span>BR2\_PACKAGE\_GNURADIO</span>

8.  Select additional GNU Radio functionalities as needed (we will need
    <span>gr-zeromq support</span> and <span>python support</span>)

9.  `/osmosdr`

10. Select <span>BR2\_PACKAGE\_GR\_OSMOSDR</span> (with Python support
    and Osmocom RTLSDR support)

11. in <span>External options</span> select <span>uhd</span> and for the
    B210 <span>b200 support</span> and <span>python API support</span>,

12. in <span>External options</span> select <span>gr-iio</span> for
    PlutoSDR support.

The resulting file will be about 550 MB, requiring increasing the
configuration in <span>.config</span> with
<span>BR2\_TARGET\_ROOTFS\_EXT2\_SIZE="420M"</span>.

Tuning the configuration prior to <span>dd</span> the SD card is
possible by adding files in <span>output/target</span>, e.g. a
<span>etc/network/interfaces</span> network configuration with a static
IP for example, or copying the USRP firmware from the host PC in the
<span>usr/share/uhd/images</span> subdirectory of
<span>output/target</span> for these files to be available later on the
target embedded board. After tuning the content of
<span>output/target</span>, execute <span>make</span> in the Buildroot
directory to re-build the <span>output/images/sdcard.img</span> file.

# GNU Radio on RPi

As a demonstration of the proper operation of GNU Radio on the embedded
board, we generate using GNU Radio Companion on the host computer a
command line interface (“No GUI”) processing flow since obviously no
graphical interface is running on the embedded target, and will execute
the resulting Python3 script on the Raspberry Pi. The audio stream
resulting from broadcast FM demodulation will be streamed to the host PC
for playing on the sound card.

On the host computer, run GNU Radio Companion (as part of GNU Radio 3.8)
and generate the following chart:

![image](target.png)

The generated Python script will be transfered and run on the RPi
platform. Make sure to adapt the 0-MQ TCP IP address to the RPi address:
the server is running on the embedded board and being a
Publish-Subscribe (like UDP broadcast) configuration, any client
connecting to the server running on the embedded board will be streamed
the dataflow. The IP address must match the subnet of the host PC for
easier routing configuration, and the port might be anything above 1024.
The only constraints on this flowgraph is to achieve a final sampling
rate matching the PC sound card sampling rate (here 48 kHz) following an
integer decimation, here tuned with an initial sampling rate of
\(48\time 24\) kS/s. The first low-pass filter selects a unique FM
broadcast station while still keeping enough bandwidth (\(\geq\)200 kHz)
for wideband FM demodulation, and the FM demodulator add the second
decimation stage.

# Communication RPi to PC

After processing the raw RF (I/Q) signal collected from the FM broadcast
band by the RPi, and preprocessing FM demodulation on the embedded
target board, the audio stream is sent PC over 0-MQ.

![image](host.png) ![image](IMG_20200527_211928small.jpg) <span>Left: client
flowchart, fetching a 0-MQ subscribe datastream and feeding the sound
card of the host PC. Right: experimental testbed, with the RPi4
connected though virtual serial port and Ethernet to the laptop PC. The
RPi4 collects an I/Q stream from the DVB-T dongle tuned to an
FM-broadcast station, streams the demodulated audio flow to the PC,
allowing to listen to the program on the headset connected to the sound
card output. Not heard on this figure is the excellent sound quality
heard on the headset, demonstrating perfect functional capability of
this setup.</span>

# Software development

We are interested in tuning the <span>gnss-sdr</span> functionalities.
The source code of the software has been downloaded in the
<span>output/build</span> directory if selected and installed. The build
directory for the target system is found in
<span>output/build/gnss-sdr-0.0.13/buildroot-build/</span> while a
separate <span>output/build/gnss-sdr-0.0.13/build</span> allows for
simultaneously testing source code modifications on the host PC. The
output of compiling (<span>make</span>), either in
<span>buildroot-build</span> (ARM target) or <span>build</span> (x86
target), is found in <span> src/main/gnss-sdr</span>.
