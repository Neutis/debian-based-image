#!/bin/bash -e

PACKAGE_NAME=neutis-n5-kernel-modules
PACKAGE_DEB_DIR=${STAGE_WORK_DIR}/packages/${PACKAGE_NAME}

mkdir -p ${PACKAGE_DEB_DIR}/lib/modules/
mkdir -p ${PACKAGE_DEB_DIR}/DEBIAN

cp -R ${LINUX_SRC}/build-modules/lib/modules/${LINUX_VERSION} ${PACKAGE_DEB_DIR}/lib/modules/

build_deb_package
install_deb_package
