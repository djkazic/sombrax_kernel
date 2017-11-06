echo "Cleaning up..."
echo
rm drivers/staging/prima/wlan.ko
make -j4 ARCH=arm64 CROSS_COMPILE=/home/synthlock/toolchains/android_prebuilts_gcc_linux-x86_aarch64_aarch64-linux-android-4.9/bin/aarch64-linux-android- clean
make -j4 ARCH=arm64 CROSS_COMPILE=/home/synthlock/toolchains/android_prebuilts_gcc_linux-x86_aarch64_aarch64-linux-android-4.9/bin/aarch64-linux-android- mrproper
