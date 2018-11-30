#!/bin/bash -e

export PACKAGE_NAME=neutis-n5-kernel-headers
export PACKAGE_DEB_DIR=${STAGE_WORK_DIR}/packages/${PACKAGE_NAME}

mkdir -p ${PACKAGE_DEB_DIR}/usr/src/linux-headers-${LINUX_VERSION}
mkdir -p ${PACKAGE_DEB_DIR}/DEBIAN

cp -R ${LINUX_SRC}/build-headers/* ${PACKAGE_DEB_DIR}/usr/src/linux-headers-${LINUX_VERSION}/
cp files/control ${PACKAGE_DEB_DIR}/DEBIAN

build_deb_package
install_deb_package
