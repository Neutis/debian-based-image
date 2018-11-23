#!/bin/bash -e

export PATH="${GCC_LINARO_SRC}/bin:$PATH"

defconfig_path=$META_EMLID_NEUTIS_SRC/meta-neutis-bsp/recipes-kernel/linux/linux-sunxi/defconfig

cp $defconfig_path $LINUX_SRC/arch/arm64/configs/neutis_defconfig
pushd $LINUX_SRC
apply_patches $META_EMLID_NEUTIS_SRC/meta-neutis-bsp/recipes-kernel/linux/linux-sunxi
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- neutis_defconfig
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- Image dtbs modules -j $CPU_CORES
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- modules_install INSTALL_MOD_PATH=./build-modules
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- headers_install INSTALL_HDR_PATH=./build-headers
rm build-modules/lib/modules/$LINUX_VERSION/build build-modules/lib/modules/$LINUX_VERSION/source
popd
