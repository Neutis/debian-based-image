#!/bin/bash -e

[[ -f ${ROOTFS_DIR}/etc/legal ]] && rm ${ROOTFS_DIR}/etc/legal

rm -f ${ROOTFS_DIR}/etc/network/interfaces

on_chroot << EOF
systemctl --no-reload mask \
ondemand.service \
ureadahead.service \
setserial.service \
etc-setserial.service \
>/dev/null 2>&1
EOF
