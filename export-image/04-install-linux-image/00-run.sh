#!/bin/bash -e

PACKAGE_NAME=neutis-n5-linux-image
LINUX_IMAGE_DEB_DIR=${STAGE_WORK_DIR}/${PACKAGE_NAME}

mkdir -p ${LINUX_IMAGE_DEB_DIR}/DEBIAN
mkdir -p ${LINUX_IMAGE_DEB_DIR}/boot

cp ${LINUX_SRC}/arch/arm64/boot/Image ${LINUX_IMAGE_DEB_DIR}/boot

cp files/control ${LINUX_IMAGE_DEB_DIR}/DEBIAN
fakeroot dpkg-deb --build ${LINUX_IMAGE_DEB_DIR}
cp ${STAGE_WORK_DIR}/${PACKAGE_NAME}.deb ${ROOTFS_DIR}/var/cache/apt/archives

on_chroot << EOF
dpkg -i /var/cache/apt/archives/${PACKAGE_NAME}.deb
EOF
