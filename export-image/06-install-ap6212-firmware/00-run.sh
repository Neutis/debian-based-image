#!/bin/bash -e

export PACKAGE_NAME=neutis-n5-ap6212-firmware
export PACKAGE_DEB_DIR=${STAGE_WORK_DIR}/packages/${PACKAGE_NAME}

AP6212_FILES="$META_EMLID_NEUTIS_SRC/meta-neutis-bsp/recipes-bsp/ap6212-firmware/files"
AP6212_PATH=${PACKAGE_DEB_DIR}/lib/firmware/ap6212
BRCM_PATH=${PACKAGE_DEB_DIR}/lib/firmware/brcm

mkdir -p ${AP6212_PATH}
mkdir -p ${BRCM_PATH}
mkdir -p ${PACKAGE_DEB_DIR}/DEBIAN

cp ${AP6212_FILES}/bcm43438a1.hcd ${AP6212_PATH}
cp ${AP6212_FILES}/brcmfmac43430a0-sdio.bin ${AP6212_PATH}
cp ${AP6212_FILES}/brcmfmac43430-sdio.bin ${AP6212_PATH}
cp ${AP6212_FILES}/brcmfmac43430-sdio.txt ${AP6212_PATH}
cp ${AP6212_FILES}/LICENSE.broadcom ${AP6212_PATH}
cp ${AP6212_FILES}/LICENSE.broadcom_brcm80211 ${AP6212_PATH}
ln -sf /lib/firmware/ap6212/brcmfmac43430a0-sdio.bin ${BRCM_PATH}/brcmfmac43430a0-sdio.bin
ln -sf /lib/firmware/ap6212/brcmfmac43430-sdio.txt ${BRCM_PATH}/brcmfmac43430a0-sdio.txt
ln -sf /lib/firmware/ap6212/brcmfmac43430-sdio.bin ${BRCM_PATH}/brcmfmac43430-sdio.bin
ln -sf /lib/firmware/ap6212/brcmfmac43430-sdio.txt ${BRCM_PATH}/brcmfmac43430-sdio.txt
ln -sf /lib/firmware/ap6212/bcm43438a1.hcd ${BRCM_PATH}/BCM43430A1.hcd
cp files/control ${PACKAGE_DEB_DIR}/DEBIAN

build_deb_package
install_deb_package
