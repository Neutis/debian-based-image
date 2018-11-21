log (){
  date +"[%T] $@" | tee -a "${LOG_FILE}"
}
export -f log

bootstrap(){
  local ARCH=$(dpkg --print-architecture)

  if [ "$ARCH" !=  "arm64" ]; then
    local BOOTSTRAP_CMD=qemu-debootstrap
  else
    local BOOTSTRAP_CMD=debootstrap
  fi

  capsh --drop=cap_setfcap -- -c "${BOOTSTRAP_CMD} --components=main,contrib,non-free \
    --arch arm64 \
    --variant=minbase \
    $1 $2 $3" || rmdir "$2/debootstrap"
}
export -f bootstrap

copy_previous(){
  if [ ! -d "${PREV_ROOTFS_DIR}" ]; then
    echo "Previous stage rootfs not found"
    false
  fi
  mkdir -p "${ROOTFS_DIR}"
  rsync -aHAXx --exclude var/cache/apt/archives "${PREV_ROOTFS_DIR}/" "${ROOTFS_DIR}/"
}
export -f copy_previous

unmount(){
  if [ -z "$1" ]; then
    DIR=$PWD
  else
    DIR=$1
  fi

  while mount | grep -q "$DIR"; do
    local LOCS
    LOCS=$(mount | grep "$DIR" | cut -f 3 -d ' ' | sort -r)
    for loc in $LOCS; do
      umount "$loc"
    done
  done
}
export -f unmount

unmount_image(){
  sync
  sleep 1
  local LOOP_DEVICES
  LOOP_DEVICES=$(losetup -j "${1}" | cut -f1 -d':')
  for LOOP_DEV in ${LOOP_DEVICES}; do
    if [ -n "${LOOP_DEV}" ]; then
      local MOUNTED_DIR
      MOUNTED_DIR=$(mount | grep "$(basename "${LOOP_DEV}")" | head -n 1 | cut -f 3 -d ' ')
      if [ -n "${MOUNTED_DIR}" ] && [ "${MOUNTED_DIR}" != "/" ]; then
        unmount "$(dirname "${MOUNTED_DIR}")"
      fi
      sleep 1
      losetup -d "${LOOP_DEV}"
    fi
  done
}
export -f unmount_image

on_chroot() {
  if [[ -z "${ROOTFS_DIR}" ]]; then
    echo "ROOTFS_DIR variable is empty, unable to mount."
    exit 1
  fi

  if ! mount | grep -q "$(realpath "${ROOTFS_DIR}"/proc)"; then
    mount -t proc proc "${ROOTFS_DIR}/proc"
  fi

  if ! mount | grep -q "$(realpath "${ROOTFS_DIR}"/dev)"; then
    mount --bind /dev "${ROOTFS_DIR}/dev"
  fi

  if ! mount | grep -q "$(realpath "${ROOTFS_DIR}"/dev/pts)"; then
    mount --bind /dev/pts "${ROOTFS_DIR}/dev/pts"
  fi

  if ! mount | grep -q "$(realpath "${ROOTFS_DIR}"/sys)"; then
    mount --bind /sys "${ROOTFS_DIR}/sys"
  fi

  capsh --drop=cap_setfcap "--chroot=${ROOTFS_DIR}/" -- "$@"
}
export -f on_chroot

apply_patches()
{
  local patches_dir=$1
  local patchfiles=`ls $patches_dir | grep .patch`
  for patch in $patchfiles; do
    echo "Applying $patch patchfile."
    patch --batch --silent -p1 -N < "${patches_dir}/${patch}"
  done;
}
export -f apply_patches

build_deb_package()
{
  local package_source_dir=$1
  local package_name=${package_source_dir}.deb

  cp files/control ${package_source_dir}/DEBIAN
  fakeroot dpkg-deb --build ${package_source_dir}
  cp ${package_name} ${ROOTFS_DIR}/var/cache/apt/archives
}
export -f build_deb_package

install_deb_package()
{
  local package_name=$1
  on_chroot << EOF
dpkg -i /var/cache/apt/archives/${package_name}
EOF
}
export -f install_deb_package