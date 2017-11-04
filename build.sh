echo "Initial building of dtbs..."
echo
make -j4 ARCH=arm64 CROSS_COMPILE=/home/synthlock/toolchains/android_prebuilts_gcc_linux-x86_aarch64_aarch64-linux-android-4.9/bin/aarch64-linux-android- lineage_tulip_defconfig dtbs

echo
echo "Copying built dtbs from arm to arm64..."
echo
cp arch/arm/boot/dts/*.dtb arch/arm64/boot/dts/

echo
echo "Getting ready to make final run!"
echo
make -j4 ARCH=arm64 CROSS_COMPILE=/home/synthlock/toolchains/android_prebuilts_gcc_linux-x86_aarch64_aarch64-linux-android-4.9/bin/aarch64-linux-android- lineage_tulip_defconfig Image.gz-dtb

echo
echo "Copying Image.gz-dtb to sombrax builder..."
echo
cp arch/arm64/boot/Image.gz-dtb ~/sombrax/

echo
echo "Done!"
echo
