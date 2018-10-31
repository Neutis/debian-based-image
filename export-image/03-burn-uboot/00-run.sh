#!/bin/bash -e

IMG_FILE="${STAGE_WORK_DIR}/${IMG_DATE}-${IMG_NAME}${IMG_SUFFIX}.img"

dd if=${U_BOOT_SRC}/u-boot-sunxi-with-spl.bin of=${IMG_FILE} bs=1024 seek=8 conv=notrunc
