#!/bin/bash -e

directories_list="$BUILD_DIR \
        $SOURCES_DIR \
        $DOWNLOADS_DIR \
        $U_BOOT_SRC \
        $LINUX_SRC \
        $ATF_SUNXI_SRC \
        $GCC_LINARO_SRC
        "
for directory in $directories_list
do
    mkdir -p $directory
done