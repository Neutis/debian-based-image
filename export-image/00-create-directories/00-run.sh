#!/bin/bash -e

export BOOT_DIR="${ROOTFS_DIR}/boot"
export ALLWINNER_DIR="${BOOT_DIR}/allwinner"
export OVERLAY_DIR="${ALLWINNER_DIR}/overlay"
export MODULES_DIR="${ROOTFS_DIR}/lib/modules/"

directories_list="$ALLWINNER_DIR $OVERLAY_DIR $MODULES_DIR"

for directory in $directories_list
do
    mkdir -p $directory
done