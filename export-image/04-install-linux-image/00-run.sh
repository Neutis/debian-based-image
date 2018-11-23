#!/bin/bash -e

export PACKAGE_NAME=neutis-n5-linux-image
export PACKAGE_DEB_DIR=${STAGE_WORK_DIR}/packages/${PACKAGE_NAME}

mkdir -p ${PACKAGE_DEB_DIR}/DEBIAN
mkdir -p ${PACKAGE_DEB_DIR}/boot

cp ${LINUX_SRC}/arch/arm64/boot/Image ${PACKAGE_DEB_DIR}/boot

build_deb_package
install_deb_package
