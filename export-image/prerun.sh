#!/bin/bash -e

BOOT_DEFAULT_SIZE=40
BOOT_PARTITION_FIRST_SECTOR=4096
BACKLASH_SIZE=200

IMG_FILE="${STAGE_WORK_DIR}/${IMG_DATE}-${IMG_NAME}${IMG_SUFFIX}.img"

unmount_image ${IMG_FILE}

rm -f ${IMG_FILE}

rm -rf ${ROOTFS_DIR}
mkdir -p ${ROOTFS_DIR}

BOOT_SIZE=$((BOOT_DEFAULT_SIZE * 1024 * 1024 - 256))
TOTAL_SIZE=$(du --bytes -s ${EXPORT_ROOTFS_DIR} --exclude var/cache/apt/archives | cut -f 1)

IMG_SIZE=$((BOOT_SIZE + TOTAL_SIZE + (BACKLASH_SIZE * 1024 * 1024)))

truncate -s ${IMG_SIZE} ${IMG_FILE}
fdisk -H 255 -S 63 ${IMG_FILE} <<EOF
o
n


$BOOT_PARTITION_FIRST_SECTOR
+$((BOOT_SIZE/512))
p
t
c
n


$BOOT_PARTITION_FIRST_SECTOR


p
w
EOF

PARTED_OUT=$(parted -s ${IMG_FILE} unit b print)
BOOT_OFFSET=$(echo "$PARTED_OUT" | grep -e '^ 1'| xargs echo -n \
| cut -d" " -f 2 | tr -d B)
BOOT_LENGTH=$(echo "$PARTED_OUT" | grep -e '^ 1'| xargs echo -n \
| cut -d" " -f 4 | tr -d B)

ROOT_OFFSET=$(echo "$PARTED_OUT" | grep -e '^ 2'| xargs echo -n \
| cut -d" " -f 2 | tr -d B)
ROOT_LENGTH=$(echo "$PARTED_OUT" | grep -e '^ 2'| xargs echo -n \
| cut -d" " -f 4 | tr -d B)

ls ${IMG_FILE}

BOOT_DEV=$(losetup --show -f -o ${BOOT_OFFSET} --sizelimit ${BOOT_LENGTH} ${IMG_FILE})
ROOT_DEV=$(losetup --show -f -o ${ROOT_OFFSET} --sizelimit ${ROOT_LENGTH} ${IMG_FILE})
echo "/boot: offset $BOOT_OFFSET, length $BOOT_LENGTH"
echo "/:     offset $ROOT_OFFSET, length $ROOT_LENGTH"

ROOT_FEATURES="^huge_file"
for FEATURE in metadata_csum 64bit; do
	if grep -q "$FEATURE" /etc/mke2fs.conf; then
	    ROOT_FEATURES="^$FEATURE,$ROOT_FEATURES"
	fi
done
mkdosfs -n boot -F 32 -v $BOOT_DEV > /dev/null
mkfs.ext4 -O $ROOT_FEATURES $ROOT_DEV > /dev/null

mount -v $ROOT_DEV ${ROOTFS_DIR} -t ext4
mkdir -p ${ROOTFS_DIR}/boot
mount -v $BOOT_DEV ${ROOTFS_DIR}/boot -t vfat

rsync -aHAXx --exclude var/cache/apt/archives ${EXPORT_ROOTFS_DIR}/ ${ROOTFS_DIR}/
