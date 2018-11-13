#!/bin/bash -e

PACKAGE_NAME=neutis-n5-kernel-modules
KERNEL_MODULES_DEB_DIR=${STAGE_WORK_DIR}/${PACKAGE_NAME}

mkdir -p ${KERNEL_MODULES_DEB_DIR}/lib/modules/
mkdir -p ${KERNEL_MODULES_DEB_DIR}/DEBIAN
rm -rf ${ROOTFS_DIR}/var/cache/apt/archives
mkdir -p ${ROOTFS_DIR}/var/cache/apt/archives

cp -R ${LINUX_SRC}/build-modules/lib/modules/${LINUX_VERSION} ${KERNEL_MODULES_DEB_DIR}/lib/modules/
cp files/control ${KERNEL_MODULES_DEB_DIR}/DEBIAN

fakeroot dpkg-deb --build ${KERNEL_MODULES_DEB_DIR}
cp ${STAGE_WORK_DIR}/${PACKAGE_NAME}.deb ${ROOTFS_DIR}/var/cache/apt/archives

on_chroot << EOF
dpkg -i /var/cache/apt/archives/${PACKAGE_NAME}.deb
EOF
