#!/bin/bash -e

GCC_LINARO_ARCHIVE_NAME="gcc-linaro.tar.gz"
GCC_SOURCE_LINK="https://releases.linaro.org/components/toolchain/binaries/latest-7/aarch64-linux-gnu/gcc-linaro-${GCC_LINARO_VERSION}-2018.05-x86_64_aarch64-linux-gnu.tar.xz"

if [ ! -f "$DOWNLOADS_DIR/$GCC_LINARO_ARCHIVE_NAME" ]; then
    wget $GCC_SOURCE_LINK \
    --output-document=$DOWNLOADS_DIR/$GCC_LINARO_ARCHIVE_NAME --no-verbose
fi

if [[ -z "$(ls -A $GCC_LINARO_SRC)" ]]; then
    tar -xf $DOWNLOADS_DIR/$GCC_LINARO_ARCHIVE_NAME \
        --directory $GCC_LINARO_SRC \
        --strip-components=1
fi
