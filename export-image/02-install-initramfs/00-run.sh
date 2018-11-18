#!/bin/bash -e

ROCKO_META_EMLID_NEUTIS_HASH=858be875304f728db22a7f921dfd2ee635b9a191

PACKAGE_NAME=neutis-n5-initramfs
INITRAMFS_DEB_DIR=${STAGE_WORK_DIR}/${PACKAGE_NAME}

mkdir -p ${INITRAMFS_DEB_DIR}/boot
mkdir -p ${INITRAMFS_DEB_DIR}/DEBIAN


pushd ${STAGE_WORK_DIR}
cp ${META_EMLID_NEUTIS_SRC}/meta-neutis-bsp/recipes-bsp/u-boot/u-boot/boot.cmd .
apply_patches ${SUB_STAGE_DIR}/files
mkimage -C none -A arm -T script -d boot.cmd boot.scr
cp boot.scr ${INITRAMFS_DEB_DIR}/boot
popd

cp $META_EMLID_NEUTIS_SRC/meta-neutis-bsp/recipes-bsp/u-boot/u-boot/Env.txt $INITRAMFS_DEB_DIR/boot

git -C ${META_EMLID_NEUTIS_SRC} checkout ${ROCKO_META_EMLID_NEUTIS_HASH} >-
cp ${META_EMLID_NEUTIS_SRC}/meta-neutis-bsp/recipes-bsp/neutis-initramfs/files/uInitrd ${INITRAMFS_DEB_DIR}/boot
git -C ${META_EMLID_NEUTIS_SRC} checkout - >-

cp files/control ${INITRAMFS_DEB_DIR}/DEBIAN
fakeroot dpkg-deb --build ${INITRAMFS_DEB_DIR}
cp ${STAGE_WORK_DIR}/${PACKAGE_NAME}.deb ${ROOTFS_DIR}/var/cache/apt/archives

on_chroot << EOF
dpkg -i /var/cache/apt/archives/${PACKAGE_NAME}.deb
EOF
