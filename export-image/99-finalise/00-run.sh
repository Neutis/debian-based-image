#!/bin/bash -e

IMG_FILE="${STAGE_WORK_DIR}/${IMG_DATE}-${IMG_NAME}${IMG_SUFFIX}.img"
rm -rf ${ROOTFS_DIR}/var/cache/apt/archives
unmount_image ${IMG_FILE}

mkdir -p ${DEPLOY_DIR}
mv ${IMG_FILE} ${DEPLOY_DIR}
