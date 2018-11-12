#!/bin/bash -e

ROCKO_META_EMLID_NEUTIS_HASH=858be875304f728db22a7f921dfd2ee635b9a191

linux_allwinner_dir="${LINUX_SRC}/arch/arm64/boot/dts/allwinner"
linux_overlay_dir="${linux_allwinner_dir}/overlay"

export BOOT_DIR="${ROOTFS_DIR}/boot"
export ALLWINNER_DIR="${BOOT_DIR}/allwinner"
export OVERLAY_DIR="${ALLWINNER_DIR}/overlay"

pushd ${STAGE_WORK_DIR}
cp ${META_EMLID_NEUTIS_SRC}/meta-neutis-bsp/recipes-bsp/u-boot/u-boot/boot.cmd .
apply_patches ${SUB_STAGE_DIR}/files
mkimage -C none -A arm -T script -d boot.cmd boot.scr
cp boot.scr ${BOOT_DIR}
popd

cp $META_EMLID_NEUTIS_SRC/meta-neutis-bsp/recipes-bsp/u-boot/u-boot/Env.txt $BOOT_DIR
cp $LINUX_SRC/arch/arm64/boot/Image $BOOT_DIR
cp ${linux_allwinner_dir}/sun50i-h5-emlid-neutis-n5-devboard.dtb $ALLWINNER_DIR
cp ${linux_allwinner_dir}/sun50i-h5-emlid-neutis-n5.dtb $ALLWINNER_DIR
cp ${linux_overlay_dir}/sun50i-h5-analog-codec.dtbo $OVERLAY_DIR
cp ${linux_overlay_dir}/sun50i-h5-cir.dtbo $OVERLAY_DIR
cp ${linux_overlay_dir}/sun50i-h5-ethernet-100.dtbo $OVERLAY_DIR
cp ${linux_overlay_dir}/sun50i-h5-spi0-status-okay.dtbo $OVERLAY_DIR
cp ${linux_overlay_dir}/sun50i-h5-spi1-status-okay.dtbo $OVERLAY_DIR
cp ${linux_overlay_dir}/sun50i-h5-uart1.dtbo $OVERLAY_DIR
cp ${linux_overlay_dir}/sun50i-h5-uart2.dtbo $OVERLAY_DIR
cp ${linux_overlay_dir}/sun50i-h5-uart3.dtbo $OVERLAY_DIR
cp ${linux_overlay_dir}/sun50i-h5-r-uart.dtbo $OVERLAY_DIR
cp ${linux_overlay_dir}/sun50i-h5-i2c0.dtbo $OVERLAY_DIR
cp ${linux_overlay_dir}/sun50i-h5-i2c1.dtbo $OVERLAY_DIR
cp ${linux_overlay_dir}/sun50i-h5-i2c2.dtbo $OVERLAY_DIR
cp ${linux_overlay_dir}/sun50i-h5-r-i2c.dtbo $OVERLAY_DIR
cp ${linux_overlay_dir}/sun50i-h5-usbhost0.dtbo $OVERLAY_DIR
cp ${linux_overlay_dir}/sun50i-h5-usbhost1.dtbo $OVERLAY_DIR
cp ${linux_overlay_dir}/sun50i-h5-usbhost2.dtbo $OVERLAY_DIR
cp ${linux_overlay_dir}/sun50i-h5-usbhost3.dtbo $OVERLAY_DIR
cp ${linux_overlay_dir}/sun50i-h5-hdmi.dtbo $OVERLAY_DIR
cp ${linux_overlay_dir}/sun50i-h5-camera-status-okay.dtbo $OVERLAY_DIR

git -C ${META_EMLID_NEUTIS_SRC} checkout ${ROCKO_META_EMLID_NEUTIS_HASH} >-
cp ${META_EMLID_NEUTIS_SRC}/meta-neutis-bsp/recipes-bsp/neutis-initramfs/files/uInitrd ${BOOT_DIR}
