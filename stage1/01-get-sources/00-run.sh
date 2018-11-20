#!/bin/bash -e

LINUX_SOURCE_LINK="https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/snapshot/${LINUX_ARCHIVE_NAME}"
U_BOOT_SOURCE_LINK="https://github.com/u-boot/u-boot/archive/v${U_BOOT_VERSION}.tar.gz"
ATF_SOURCE_LINK="https://github.com/apritzel/arm-trusted-firmware.git"
ATF_SOURCE_BRANCH="master"
ATF_SOURCE_COMMIT_HASH=7db0c96023281d8a530f5e011a232e5d56557437
GCC_SOURCE_LINK="https://releases.linaro.org/components/toolchain/binaries/latest-7/aarch64-linux-gnu/gcc-linaro-${GCC_LINARO_VERSION}-2018.05-x86_64_aarch64-linux-gnu.tar.xz"
META_EMLID_NEUTIS_SOURCE_LINK="https://github.com/Neutis/meta-emlid-neutis.git"
META_EMLID_NEUTIS_BRANCH="sumo"
META_EMLID_NEUTIS_COMMIT_HASH=e020b06b5c5b36581ae72ab7a4b932913cdf96a0
META_SUNXI_SOURCE_LINK="https://github.com/Neutis/meta-sunxi.git"
META_SUNXI_BRANCH="sumo"
META_SUNXI_COMMIT_HASH=2c71a7d593f7d35b1bb8fec7aa3944b0295e036e


if [ ! -f "$DOWNLOADS_DIR/$LINUX_ARCHIVE_NAME" ]; then
    wget  $LINUX_SOURCE_LINK \
    --output-document=$DOWNLOADS_DIR/$LINUX_ARCHIVE_NAME --no-verbose
fi
if [ ! -f "$DOWNLOADS_DIR/$U_BOOT_ARCHIVE_NAME" ]; then
    wget $U_BOOT_SOURCE_LINK \
    --output-document=$DOWNLOADS_DIR/$U_BOOT_ARCHIVE_NAME --no-verbose
fi
if [ ! -f "$DOWNLOADS_DIR/$GCC_LINARO_ARCHIVE_NAME" ]; then
    wget $GCC_SOURCE_LINK \
    --output-document=$DOWNLOADS_DIR/$GCC_LINARO_ARCHIVE_NAME --no-verbose
fi
if [ ! -d "$ATF_SUNXI_SRC" ]; then
    git clone -b $ATF_SOURCE_BRANCH --single-branch $ATF_SOURCE_LINK $ATF_SUNXI_SRC
    git -C $ATF_SUNXI_SRC checkout $ATF_SOURCE_COMMIT_HASH >-
fi
if [ ! -d $META_EMLID_NEUTIS_SRC ]; then
    git clone -b $META_EMLID_NEUTIS_BRANCH --single-branch $META_EMLID_NEUTIS_SOURCE_LINK $META_EMLID_NEUTIS_SRC
    git -C $META_EMLID_NEUTIS_SRC checkout $META_EMLID_NEUTIS_COMMIT_HASH >-
fi
if [ ! -d $META_SUNXI_SRC ]; then
    git clone -b $META_SUNXI_BRANCH --single-branch $META_SUNXI_SOURCE_LINK $META_SUNXI_SRC
    git -C $META_SUNXI_SRC checkout $META_SUNXI_COMMIT_HASH >-
fi

if [[ -z "$(ls -A $LINUX_SRC)" ]]; then
    tar -zxf $DOWNLOADS_DIR/$LINUX_ARCHIVE_NAME \
        --directory $LINUX_SRC \
        --strip-components=1
fi
if [[ -z "$(ls -A $U_BOOT_SRC)" ]]; then
    tar -zxf $DOWNLOADS_DIR/$U_BOOT_ARCHIVE_NAME \
        --directory $U_BOOT_SRC \
        --strip-components=1
fi
if [[ -z "$(ls -A $GCC_LINARO_SRC)" ]]; then
    tar -xf $DOWNLOADS_DIR/$GCC_LINARO_ARCHIVE_NAME \
        --directory $GCC_LINARO_SRC \
        --strip-components=1
fi
