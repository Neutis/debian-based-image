#!/bin/bash -e

install -m 644 files/sources.list ${ROOTFS_DIR}/etc/apt/
install -m 644 files/neutis.list ${ROOTFS_DIR}/etc/apt/sources.list.d/
install -m 644 files/hosts ${ROOTFS_DIR}/etc/hosts
install -m 644 files/hostname ${ROOTFS_DIR}/etc/hostname

on_chroot << EOF
apt-get update
apt-get upgrade -y
EOF
