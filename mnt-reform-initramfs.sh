#!/bin/bash
set -euo pipefail
shopt -s nullglob

KMOD_DIRS=(/usr/lib/modules/*-mnt-reform)

if (( ${#KMOD_DIRS[@]} == 0 )); then
  echo "==> No linux-mnt-reform kernels found, skipping initramfs"
  exit 0
fi

echo "==> Updating module dependencies"
for dir in "${KMOD_DIRS[@]}"; do
  KVER="$(basename "$dir")"
  echo "  -> depmod $KVER"
  /usr/bin/depmod "$KVER"
done

# Select newest kernel by version
KVER_LATEST="$(
  printf "%s\n" "${KMOD_DIRS[@]##*/}" | sort -V | tail -n1
)"

echo "==> Using latest kernel: $KVER_LATEST"

# Maintain testing symlink
if [ -f /boot/Image-linux-mnt-reform]; then
  ln -sf Image-linux-mnt-reform /boot/Image-testing
fi

echo "==> Building initramfs for $KVER_LATEST"
/usr/bin/dracut -f /boot/initramfs-linux-testing \
  --kver "$KVER_LATEST" \
  --no-hostonly \
  --add-drivers "nvme nvme_core nvme_keyring nvme_auth"

