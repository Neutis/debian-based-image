#!/bin/bash -e

install -m 644 files/locale.conf ${ROOTFS_DIR}/etc/locale.conf

on_chroot << EOF
echo "LC_ALL=en_US.UTF-8" >> /etc/environment
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen en_US.UTF-8
EOF
