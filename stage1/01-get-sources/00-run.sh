#!/bin/bash -e

LINUX_ARCHIVE_NAME="linux-${LINUX_VERSION}.tar.gz"
LINUX_SOURCE_LINK="https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/snapshot/${LINUX_ARCHIVE_NAME}"

if [ ! -f "${DOWNLOADS_DIR}/${LINUX_ARCHIVE_NAME}.done" ]; then
    wget ${LINUX_SOURCE_LINK} \
    --output-document=${DOWNLOADS_DIR}/${LINUX_ARCHIVE_NAME} --no-verbose
    touch "${DOWNLOADS_DIR}/${LINUX_ARCHIVE_NAME}.done"
fi

if [[ -z "$(ls -A ${LINUX_SRC})" ]]; then
    tar -zxf ${DOWNLOADS_DIR}/${LINUX_ARCHIVE_NAME} \
        --directory ${LINUX_SRC} \
        --strip-components=1
fi
