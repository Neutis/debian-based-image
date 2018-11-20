#!/bin/bash -e

PACKAGE_NAME=neutis-n5-kernel-modules
KERNEL_MODULES_DEB_DIR=${STAGE_WORK_DIR}/packages/${PACKAGE_NAME}

mkdir -p ${KERNEL_MODULES_DEB_DIR}/lib/modules/
mkdir -p ${KERNEL_MODULES_DEB_DIR}/DEBIAN

cp -R ${LINUX_SRC}/build-modules/lib/modules/${LINUX_VERSION} ${KERNEL_MODULES_DEB_DIR}/lib/modules/

build_deb_package ${KERNEL_MODULES_DEB_DIR}
install_deb_package ${PACKAGE_NAME}.deb
