#!/bin/bash -e

export BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export LIB_DIR="${BASE_DIR}/lib"

source ${LIB_DIR}/stages.sh
source ${LIB_DIR}/common.sh
source ${LIB_DIR}/config.sh

check_build_environment
check_root_rights
apply_config_file


export IMG_DATE=${IMG_DATE:-"$(date +%Y-%m-%d-%H:%M)"}

export WORK_DIR=${WORK_DIR:-"${BASE_DIR}/work/${IMG_NAME}"}
export DEPLOY_DIR=${DEPLOY_DIR:-"${BASE_DIR}/deploy"}
export LOG_FILE="${WORK_DIR}/build.log"
export DEFAULT_DEVICE_NAME="-neutis-n5"

export DOWNLOADS_DIR="${WORK_DIR}/downloads"
export SOURCES_DIR="${WORK_DIR}/sources"

export LINUX_VERSION="4.17.2"
export LINUX_SRC="${SOURCES_DIR}/linux"

export U_BOOT_VERSION="2018.07"
export U_BOOT_SRC="${SOURCES_DIR}/u-boot"

export GCC_LINARO_VERSION="7.3.1"
export GCC_LINARO_SRC="${SOURCES_DIR}/gcc-linaro"

export ATF_SUNXI_SRC="${SOURCES_DIR}/atf-sunxi"
export META_EMLID_NEUTIS_SRC="${SOURCES_DIR}/meta-emlid-neutis"
export META_SUNXI_SRC="${SOURCES_DIR}/meta-sunxi"

export CLEAN
export IMG_NAME
export CPU_CORES

export STAGE
export STAGE_DIR
export SUB_STAGE_DIR
export STAGE_WORK_DIR
export PREV_STAGE
export PREV_STAGE_DIR
export ROOTFS_DIR
export PREV_ROOTFS_DIR
export IMG_SUFFIX
export EXPORT_DIR
export EXPORT_ROOTFS_DIR

export QUILT_PATCHES
export QUILT_NO_DIFF_INDEX=1
export QUILT_NO_DIFF_TIMESTAMPS=1
export QUILT_REFRESH_ARGS="-p ab"


mkdir -p ${WORK_DIR}
log "Begin ${BASE_DIR}"

set_up_stages_skip
set_up_export_stages
for STAGE_DIR in ${BASE_DIR}/stage*; do
	run_stage
done

CLEAN=1
for EXPORT_DIR in ${EXPORT_DIRS}; do
	STAGE_DIR=${BASE_DIR}/export-image
	source "${EXPORT_DIR}/EXPORT_IMAGE"
	EXPORT_ROOTFS_DIR=${WORK_DIR}/$(basename ${EXPORT_DIR})/rootfs
	run_stage
done

if [ -x postrun.sh ]; then
	log "Begin postrun.sh"
	cd "${BASE_DIR}"
	./postrun.sh
	log "End postrun.sh"
fi

log "End ${BASE_DIR}"
