#!/bin/bash -e

PACKAGE_NAME=neutis-n5-kernel-headers
KERNEL_HEADERS_DEB_DIR=${STAGE_WORK_DIR}/packages/${PACKAGE_NAME}

mkdir -p ${KERNEL_HEADERS_DEB_DIR}/usr/src/linux-headers-${LINUX_VERSION}
mkdir -p ${KERNEL_HEADERS_DEB_DIR}/DEBIAN

cp -R ${LINUX_SRC}/build-headers/include/* ${KERNEL_HEADERS_DEB_DIR}/usr/src/linux-headers-${LINUX_VERSION}
cp files/control ${KERNEL_HEADERS_DEB_DIR}/DEBIAN

build_deb_package ${KERNEL_HEADERS_DEB_DIR}
install_deb_package ${PACKAGE_NAME}.deb
