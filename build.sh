echo "Initial building of dtbs..."
echo
make -j4 ARCH=arm64 CROSS_COMPILE=/home/synthlock/toolchains/android_prebuilts_gcc_linux-x86_aarch64_aarch64-linux-android-4.9/bin/aarch64-linux-android- lineage_tulip_defconfig dtbs

echo
echo "Copying built dtbs from arm to arm64..."
echo
cp arch/arm/boot/dts/*.dtb arch/arm64/boot/dts/

echo
echo "Building modules..."
echo
make -j4 ARCH=arm64 CROSS_COMPILE=/home/synthlock/toolchains/android_prebuilts_gcc_linux-x86_aarch64_aarch64-linux-android-4.9/bin/aarch64-linux-android- lineage_tulip_defconfig modules

echo
echo "Getting ready to make final run!"
echo
make -j4 ARCH=arm64 CROSS_COMPILE=/home/synthlock/toolchains/android_prebuilts_gcc_linux-x86_aarch64_aarch64-linux-android-4.9/bin/aarch64-linux-android- lineage_tulip_defconfig Image.gz-dtb

echo
echo "Copying Image.gz-dtb to sombrax builder..."
echo
cp arch/arm64/boot/Image.gz-dtb ~/sombrax/

echo
echo "Stripping wlan.ko module..."
echo
/home/synthlock/toolchains/android_prebuilts_gcc_linux-x86_aarch64_aarch64-linux-android-4.9/bin/aarch64-linux-android-strip --strip-debug drivers/staging/prima/wlan.ko

echo
echo "Copying modules to sombrax builder..."
echo
cp -v drivers/staging/prima/wlan.ko ~/sombrax/modules/

echo
echo "Zipping sombrax with AnyKernel 2..."
echo
version=$(cat .version)
kernel_date=$(echo $(date +%F))
cwd_build=$(pwd)
cd ~/sombrax/
name_zip="sombrax-v${version}-${kernel_date}.zip"
zip -r $name_zip ./*
mv $name_zip $cwd_build

echo
echo "Done!"
echo
