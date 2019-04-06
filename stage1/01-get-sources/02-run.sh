#!/bin/bash -e

GCC_LINARO_ARCHIVE_NAME="gcc-linaro.tar.gz"
GCC_SOURCE_LINK="https://releases.linaro.org/components/toolchain/binaries/${GCC_LINARO_VERSION}/aarch64-linux-gnu/gcc-linaro-7.4.1-2019.02-x86_64_aarch64-linux-gnu.tar.xz"

if [ ! -f "${DOWNLOADS_DIR}/${GCC_LINARO_ARCHIVE_NAME}.done" ]; then
    wget ${GCC_SOURCE_LINK} \
    --output-document=${DOWNLOADS_DIR}/${GCC_LINARO_ARCHIVE_NAME} --no-verbose
    touch "${DOWNLOADS_DIR}/${GCC_LINARO_ARCHIVE_NAME}.done"
fi

if [ ! -f "${GCC_LINARO_SRC}.done" ]; then
    tar -xf ${DOWNLOADS_DIR}/${GCC_LINARO_ARCHIVE_NAME} \
        --directory ${GCC_LINARO_SRC} \
        --strip-components=1
    touch "${GCC_LINARO_SRC}.done"
fi
