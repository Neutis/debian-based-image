#!/bin/bash -e

BOOT_DIR="${ROOTFS_DIR}/boot"
ALLWINNER_DIR="${BOOT_DIR}/allwinner"
OVERLAY_DIR="${ALLWINNER_DIR}/overlay"
MODULES_DIR="${ROOTFS_DIR}/lib/modules/"
PACKAGES_DIR="${STAGE_WORK_DIR}/packages"

directories_list="$ALLWINNER_DIR $OVERLAY_DIR $MODULES_DIR $PACKAGES_DIR"

for directory in $directories_list
do
    mkdir -p $directory
done
