echo "Setting env variables for pre-compile..."
export CROSS_COMPILE="/home/synthlock/toolchains/aarch64-linaro-linux-android/bin/aarch64-linaro-linux-android-"
export ARCH="arm64"
echo "Sanity check:"
echo $ARCH
echo $CROSS_COMPILE
echo

echo "Initial building of dtbs..."
echo
make -j4 lineage_tulip_defconfig dtbs
echo

echo "Copying built dtbs from arm to arm64..."
echo
cp arch/arm/boot/dts/*.dtb arch/arm64/boot/dts/

echo
echo "Building modules..."
echo
make -j4 modules

echo
echo "Getting ready to make final run!"
echo
make -j4 Image.gz-dtb

echo
echo "Copying Image.gz-dtb to sombrax builder..."
echo
cp arch/arm64/boot/Image.gz-dtb ~/sombrax/

echo
echo "Stripping wlan.ko module..."
echo
$CROSS_COMPILE-strip --strip-debug drivers/staging/prima/wlan.ko

echo
echo "Copying modules to sombrax builder..."
echo
cp -v drivers/staging/prima/wlan.ko ~/sombrax/modules/

echo
echo "Zipping sombrax with AnyKernel 2..."
echo
version=$(cat .version)
kernel_date=$(echo $(date +%Y-%m-%d-%H%M))
cd ~/sombrax/
name_zip="sombrax-v${version}-${kernel_date}.zip"
zip -r $name_zip ./*
mv $name_zip ~

echo
echo "Done!"
echo
