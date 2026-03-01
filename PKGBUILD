# Maintainer: Stephano Cetola <stephanoc@gmail.com>

pkgbase=linux-mnt-reform
pkgname=('linux-mnt-reform' 'linux-mnt-reform-headers')
pkgver=6.18.15
pkgrel=1
_kernver="${pkgver}-mnt-reform"
arch=('aarch64')
url="https://github.com/cetola/mnt-build"
license=('GPL2')
options=(!strip !docs !emptydirs)
source=(
  "kernel-${pkgver}-${pkgrel}-mnt.tar.gz::https://github.com/cetola/mnt-build/releases/download/${pkgver}-${pkgrel}-mnt-reform/kernel-${pkgver}-${pkgrel}-mnt.tar.gz"
  "headers-${pkgver}-${pkgrel}-mnt.tar.gz::https://github.com/cetola/mnt-build/releases/download/${pkgver}-${pkgrel}-mnt-reform/headers-${pkgver}-${pkgrel}-mnt.tar.gz"
  'extlinux.conf.example'
  'mnt-reform-initramfs.hook'
  'mnt-reform-initramfs.sh'
)
sha256sums=(
  'de2908b51d7c792cc85ddeeac7a37b14d55f50ddabd7a46c26155b4f47097cc2'
  'a0db7992bbe5764a2aae9cec24c7c4cdcc2ae1f5db9ffea2c29f461b31aceff0'
  'b83bfbb4eea8d7186d52f1157966e6761e2a159799a8b2bc84677b2624aeea9c'
  'ff6aeb3704c23e690dbf975602266fa03a8c0c532808bd7d0af9eb05e4afd3ad'
  '89d69f287c48fe918b41fc45db7a7a570435998ac4bce28e13fa117faa78be0f'
)

build() {
  :
}

package_linux-mnt-reform() {
  pkgdesc='Linux kernel for MNT Reform (arm64)'
  depends=('dracut' 'kmod' 'cpio')
  provides=('linux' 'linux-aarch64')
  conflicts=('linux')
  install='linux-mnt-reform.install'

  cd "$srcdir"

  install -dm755 "$pkgdir/usr/lib/modules/${_kernver}"
  cp -r "lib/modules/${_kernver}"/* "$pkgdir/usr/lib/modules/${_kernver}/"

  install -Dm644 'arch/arm64/boot/Image' \
    "$pkgdir/boot/Image-linux-mnt-reform"

  install -dm755 "$pkgdir/boot/dtbs"
  for dtb in *.dtb; do
    [[ -f "$dtb" ]] || continue
    install -Dm644 "$dtb" "$pkgdir/boot/dtbs/$dtb"
  done

  install -Dm644 "$srcdir/extlinux.conf.example" \
    "$pkgdir/usr/share/doc/linux-mnt-reform/extlinux.conf.example"

  install -Dm644 "$srcdir/mnt-reform-initramfs.hook" \
    "$pkgdir/usr/share/libalpm/hooks/mnt-reform-initramfs.hook"

  install -Dm755 "$srcdir/mnt-reform-initramfs.sh" \
    "$pkgdir/usr/lib/linux-mnt-reform/mnt-reform-initramfs.sh"
}

package_linux-mnt-reform-headers() {
  pkgdesc='Header files and scripts for building modules for linux-mnt-reform kernel'
  depends=('perl' "linux-mnt-reform=${pkgver}-${pkgrel}")
  provides=("linux-headers=${pkgver}")
  conflicts=('linux-aarch64-headers' 'linux-headers')

  cd "$srcdir/linux-${pkgver}"

  install -dm755 "$pkgdir/usr/lib/modules/${_kernver}/build"
  echo 'Installing pre-prepared kernel headers...'
  cp -a . "$pkgdir/usr/lib/modules/${_kernver}/build"
}
