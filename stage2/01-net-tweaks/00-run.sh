#!/bin/bash -e

AP6212_FILES="$META_EMLID_NEUTIS_SRC/meta-neutis-bsp/recipes-bsp/ap6212-firmware/files"

install -d ${ROOTFS_DIR}/lib/firmware/ap6212
install -c -m 0644 ${AP6212_FILES}/bcm43438a1.hcd ${ROOTFS_DIR}/lib/firmware/ap6212
install -c -m 0644 ${AP6212_FILES}/brcmfmac43430a0-sdio.bin ${ROOTFS_DIR}/lib/firmware/ap6212
install -c -m 0644 ${AP6212_FILES}/brcmfmac43430-sdio.bin ${ROOTFS_DIR}/lib/firmware/ap6212
install -c -m 0644 ${AP6212_FILES}/brcmfmac43430-sdio.txt ${ROOTFS_DIR}/lib/firmware/ap6212

install -d ${ROOTFS_DIR}/lib/firmware/brcm

on_chroot << EOF
ln -sf /lib/firmware/ap6212/brcmfmac43430a0-sdio.bin /lib/firmware/brcm/brcmfmac43430a0-sdio.bin
ln -sf /lib/firmware/ap6212/brcmfmac43430-sdio.txt /lib/firmware/brcm/brcmfmac43430a0-sdio.txt
ln -sf /lib/firmware/ap6212/brcmfmac43430-sdio.bin /lib/firmware/brcm/brcmfmac43430-sdio.bin
ln -sf /lib/firmware/ap6212/brcmfmac43430-sdio.txt /lib/firmware/brcm/brcmfmac43430-sdio.txt
ln -sf /lib/firmware/ap6212/bcm43438a1.hcd /lib/firmware/brcm/BCM43430A1.hcd
EOF