#!/bin/bash -e

if [ ! -d "${ROOTFS_DIR}" ]; then
	bootstrap xenial "${ROOTFS_DIR}" http://ports.ubuntu.com/ubuntu-ports/
fi
