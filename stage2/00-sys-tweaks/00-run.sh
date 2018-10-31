#!/bin/bash -e

pushd ${ROOTFS_DIR}/etc/ssh
apply_patches ${SUB_STAGE_DIR}/files
popd