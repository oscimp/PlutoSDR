TARGET=pluto
BOARD_DIR=$(dirname $0)
mkimage=$HOST_DIR/bin/mkimage
dfu_suffix=$HOST_DIR/bin/dfu-suffix

DEVICE_VID=0x0456
DEVICE_PID=0xb673

cp $BOARD_DIR/pluto.its $BINARIES_DIR/pluto.its 
cp $BOARD_DIR/system_top.bit $BINARIES_DIR/system_top.bit

echo "# entering $BINARIES_DIR for the next command"
(cd $BINARIES_DIR && $mkimage -f pluto.its pluto.itb) 
 
echo "generating the pluto.frm"
md5sum $BINARIES_DIR/pluto.itb | cut -d ' ' -f 1 > $BINARIES_DIR/pluto.md5
cat $BINARIES_DIR/pluto.itb  $BINARIES_DIR/pluto.md5 > $BINARIES_DIR/pluto.frm

echo "generating pluto.dfu" 
$dfu_suffix -a $BINARIES_DIR/pluto.itb -v $DEVICE_VID -p $DEVICE_PID
mv $BINARIES_DIR/pluto.itb $BINARIES_DIR/pluto.dfu	

rm -f $BINARIES_DIR/pluto.its $BINARIES_DIR/*.md5
