#!/bin/bash -e

IMG_FILE="${STAGE_WORK_DIR}/${IMG_DATE}-${IMG_NAME}${IMG_SUFFIX}.img"
rm -rf ${ROOTFS_DIR}/var/cache/apt/archives
losetup -a | grep ${IMG_FILE} | cut -f 1 -d ' ' | sed 's/.$//' | xargs losetup -d
