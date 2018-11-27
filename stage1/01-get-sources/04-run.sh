#!/bin/bash -e

META_SUNXI_SOURCE_LINK="https://github.com/Neutis/meta-sunxi.git"
META_SUNXI_BRANCH="sumo"
META_SUNXI_COMMIT_HASH=2c71a7d593f7d35b1bb8fec7aa3944b0295e036e

if [ ! -d ${META_SUNXI_SRC} ]; then
    git clone -b $META_SUNXI_BRANCH --single-branch $META_SUNXI_SOURCE_LINK $META_SUNXI_SRC
    git -C $META_SUNXI_SRC checkout $META_SUNXI_COMMIT_HASH >-
fi
