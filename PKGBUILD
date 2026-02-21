# Maintainer: Stephano Cetola <stephanoc@gmail.com>

pkgname=linux-mnt-reform
pkgver=6.18.12
pkgrel=1
_kernver="${pkgver}-mnt-reform"
pkgdesc="Linux kernel for MNT Reform (arm64)"
arch=('aarch64')
url="https://github.com/cetola/mnt-build"
license=('GPL2')
depends=('dracut' 'kmod')
provides=('linux' 'linux-aarch64')
conflicts=('linux')
install="${pkgname}.install"
source=(
  "kernel-${pkgver}-${pkgrel}-mnt.tar.gz::https://github.com/cetola/mnt-build/releases/download/${pkgver}-${pkgrel}-mnt-reform/kernel-${pkgver}-${pkgrel}-mnt.tar.gz"
  "extlinux.conf.example"
  "mnt-reform-initramfs.hook"
  "mnt-reform-initramfs.sh"
)
sha256sums=(
  '9db16600f657a64d8608bc99dd54200ab398ec0df3c5d05aabf71da150256e99'
  'b83bfbb4eea8d7186d52f1157966e6761e2a159799a8b2bc84677b2624aeea9c'
  'ff6aeb3704c23e690dbf975602266fa03a8c0c532808bd7d0af9eb05e4afd3ad'
  '89d69f287c48fe918b41fc45db7a7a570435998ac4bce28e13fa117faa78be0f'
)

options=(!strip !docs !emptydirs)

package() {
  cd "$srcdir"

  install -dm755 "$pkgdir/usr/lib/modules/${_kernver}"
  cp -r lib/modules/${_kernver}/* "$pkgdir/usr/lib/modules/${_kernver}/"

  install -Dm644 arch/arm64/boot/Image \
    "$pkgdir/boot/Image-${pkgname}"

  # Create DTBs directory
  install -dm755 "$pkgdir/boot/dtbs"

  # Install all DTB files from the root of the archive
  for dtb in *.dtb; do
    if [ -f "$dtb" ]; then
      install -Dm644 "$dtb" "$pkgdir/boot/dtbs/$dtb"
    fi
  done

  # Determine which DTB to symlink based on device model
  if [ -f /proc/device-tree/model ]; then
    model=$(cat /proc/device-tree/model)

    case "$model" in
      "MNT Pocket Reform with BPI-CM4 Module")
        dtb_target="meson-g12b-bananapi-cm4-mnt-pocket-reform-${pkgver}.dtb"
        ;;
      "MNT Pocket Reform with i.MX8MP Module")
        dtb_target="imx8mp-mnt-pocket-reform-${pkgver}.dtb"
        ;;
      "MNT Reform Next with RCORE RK3588 Module")
        dtb_target="rk3588-mnt-reform-next-${pkgver}.dtb"
        ;;
      *)
        echo "Warning: Unknown device model: $model"
        echo "No DTB symlink will be created"
        dtb_target=""
        ;;
    esac

  # Create symlink if a target was determined
  if [ -n "$dtb_target" ] && [ -f "$pkgdir/boot/dtbs/$dtb_target" ]; then
      ln -sf "dtbs/$dtb_target" "$pkgdir/boot/mnt-reform-${pkgver}.dtb"
      ln -sf "mnt-reform-${pkgver}.dtb" "$pkgdir/boot/mnt-reform.dtb"
      echo "Created symlinks to $dtb_target for model: $model"
    elif [ -n "$dtb_target" ]; then
      echo "Warning: Target DTB $dtb_target not found in package"
    fi
  else
    echo "Warning: /proc/device-tree/model not found"
    echo "No DTB symlink will be created"
  fi

  install -Dm644 "$srcdir/extlinux.conf.example" \
    "$pkgdir/usr/share/doc/${pkgname}/extlinux.conf.example"

  install -Dm644 "$srcdir/mnt-reform-initramfs.hook" \
    "$pkgdir/usr/share/libalpm/hooks/mnt-reform-initramfs.hook"

  install -Dm755 "$srcdir/mnt-reform-initramfs.sh" \
    "$pkgdir/usr/lib/linux-mnt-reform/mnt-reform-initramfs.sh"
}
