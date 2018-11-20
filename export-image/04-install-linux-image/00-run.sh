#!/bin/bash -e

PACKAGE_NAME=neutis-n5-linux-image
LINUX_IMAGE_DEB_DIR=${STAGE_WORK_DIR}/packages/${PACKAGE_NAME}

mkdir -p ${LINUX_IMAGE_DEB_DIR}/DEBIAN
mkdir -p ${LINUX_IMAGE_DEB_DIR}/boot

cp ${LINUX_SRC}/arch/arm64/boot/Image ${LINUX_IMAGE_DEB_DIR}/boot

build_deb_package ${LINUX_IMAGE_DEB_DIR}
install_deb_package ${PACKAGE_NAME}.deb
