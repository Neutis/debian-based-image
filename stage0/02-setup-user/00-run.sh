#!/bin/bash -e

ROOTPWD="emlidneutis"

on_chroot << EOF
(echo $ROOTPWD; echo $ROOTPWD;) | passwd root >/dev/null 2>&1
EOF
