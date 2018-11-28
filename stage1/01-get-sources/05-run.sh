#!/bin/bash -e

ATF_SOURCE_LINK="https://github.com/ARM-software/arm-trusted-firmware.git"
ATF_SOURCE_BRANCH="master"
ATF_SOURCE_COMMIT_HASH=7db0c96023281d8a530f5e011a232e5d56557437

if [ ! -d ${ATF_SUNXI_SRC} ]; then
    git clone -b ${ATF_SOURCE_BRANCH} --single-branch ${ATF_SOURCE_LINK} ${ATF_SUNXI_SRC}
    git -C ${ATF_SUNXI_SRC} checkout ${ATF_SOURCE_COMMIT_HASH} >-
fi
