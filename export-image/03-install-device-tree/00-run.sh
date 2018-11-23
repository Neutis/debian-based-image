#!/bin/bash -e

LINUX_ALLWINNER_DIR="${LINUX_SRC}/arch/arm64/boot/dts/allwinner"
LINUX_OVERLAY_DIR="${LINUX_ALLWINNER_DIR}/overlay"

export PACKAGE_NAME=neutis-n5-device-tree
export PACKAGE_DEB_DIR=${STAGE_WORK_DIR}/packages/${PACKAGE_NAME}
ALLWINNER_PATH="${PACKAGE_DEB_DIR}/boot/allwinner"
OVERLAY_PATH="${ALLWINNER_PATH}/overlay"

mkdir -p ${OVERLAY_PATH}
mkdir -p ${PACKAGE_DEB_DIR}/DEBIAN

cp ${LINUX_ALLWINNER_DIR}/sun50i-h5-emlid-neutis-n5-devboard.dtb ${ALLWINNER_PATH}
cp ${LINUX_ALLWINNER_DIR}/sun50i-h5-emlid-neutis-n5.dtb ${ALLWINNER_PATH}
cp ${LINUX_OVERLAY_DIR}/sun50i-h5-analog-codec.dtbo ${OVERLAY_PATH}
cp ${LINUX_OVERLAY_DIR}/sun50i-h5-cir.dtbo ${OVERLAY_PATH}
cp ${LINUX_OVERLAY_DIR}/sun50i-h5-ethernet-100.dtbo ${OVERLAY_PATH}
cp ${LINUX_OVERLAY_DIR}/sun50i-h5-spi0-status-okay.dtbo ${OVERLAY_PATH}
cp ${LINUX_OVERLAY_DIR}/sun50i-h5-spi1-status-okay.dtbo ${OVERLAY_PATH}
cp ${LINUX_OVERLAY_DIR}/sun50i-h5-uart1.dtbo ${OVERLAY_PATH}
cp ${LINUX_OVERLAY_DIR}/sun50i-h5-uart2.dtbo ${OVERLAY_PATH}
cp ${LINUX_OVERLAY_DIR}/sun50i-h5-uart3.dtbo ${OVERLAY_PATH}
cp ${LINUX_OVERLAY_DIR}/sun50i-h5-r-uart.dtbo ${OVERLAY_PATH}
cp ${LINUX_OVERLAY_DIR}/sun50i-h5-i2c0.dtbo ${OVERLAY_PATH}
cp ${LINUX_OVERLAY_DIR}/sun50i-h5-i2c1.dtbo ${OVERLAY_PATH}
cp ${LINUX_OVERLAY_DIR}/sun50i-h5-i2c2.dtbo ${OVERLAY_PATH}
cp ${LINUX_OVERLAY_DIR}/sun50i-h5-r-i2c.dtbo ${OVERLAY_PATH}
cp ${LINUX_OVERLAY_DIR}/sun50i-h5-usbhost0.dtbo ${OVERLAY_PATH}
cp ${LINUX_OVERLAY_DIR}/sun50i-h5-usbhost1.dtbo ${OVERLAY_PATH}
cp ${LINUX_OVERLAY_DIR}/sun50i-h5-usbhost2.dtbo ${OVERLAY_PATH}
cp ${LINUX_OVERLAY_DIR}/sun50i-h5-usbhost3.dtbo ${OVERLAY_PATH}
cp ${LINUX_OVERLAY_DIR}/sun50i-h5-hdmi.dtbo ${OVERLAY_PATH}
cp ${LINUX_OVERLAY_DIR}/sun50i-h5-camera-status-okay.dtbo ${OVERLAY_PATH}

build_deb_package
install_deb_package
