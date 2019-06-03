TARGET=pluto
BOARD_DIR=$(dirname $0)
BIN_DIR=$1
mkimage=$HOST_DIR/bin/mkimage
dfu_suffix=$HOST_DIR/bin/dfu-suffix

if [ $# -eq 1 ]; then
	BIT_FILE=$BOARD_DIR/system_top.bit
else
	BIT_FILE=$2
fi

DEVICE_VID=0x0456
DEVICE_PID=0xb673

cp $BOARD_DIR/pluto.its $BIN_DIR/pluto.its
cp $BIT_FILE $BIN_DIR/system_top.bit

echo "# entering $BIN_DIR for the next command"
(cd $BIN_DIR && $mkimage -f pluto.its pluto.itb)

echo "generating the pluto.frm"
md5sum $BIN_DIR/pluto.itb | cut -d ' ' -f 1 > $BIN_DIR/pluto.md5
cat $BIN_DIR/pluto.itb  $BIN_DIR/pluto.md5 > $BIN_DIR/pluto.frm

echo "generating pluto.dfu"
$dfu_suffix -a $BIN_DIR/pluto.itb -v $DEVICE_VID -p $DEVICE_PID
mv $BIN_DIR/pluto.itb $BIN_DIR/pluto.dfu

rm -f $BIN_DIR/pluto.its $BIN_DIR/*.md5
