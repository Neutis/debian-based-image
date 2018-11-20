#!/bin/bash -e

export PATH="${GCC_LINARO_SRC}/bin:$PATH"

pushd $ATF_SUNXI_SRC
apply_patches ${META_SUNXI_SRC}/recipes-bsp/atf/files
make CROSS_COMPILE=aarch64-linux-gnu- PLAT=sun50i_a64 DEBUG=1 bl31
popd
