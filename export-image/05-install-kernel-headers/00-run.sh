#!/bin/bash -e

PACKAGE_NAME=neutis-n5-kernel-headers
PACKAGE_DEB_DIR=${STAGE_WORK_DIR}/packages/${PACKAGE_NAME}

mkdir -p ${PACKAGE_DEB_DIR}/usr/src/linux-headers-${LINUX_VERSION}
mkdir -p ${PACKAGE_DEB_DIR}/DEBIAN

cp -R ${LINUX_SRC}/build-headers/* ${PACKAGE_DEB_DIR}/usr/src/linux-headers-${LINUX_VERSION}/

build_deb_package
install_deb_package
