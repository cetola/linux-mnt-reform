# Maintainer: Stephano Cetola <stephanoc@gmail.com>

pkgbase=linux-mnt-reform
pkgname=('linux-mnt-reform' 'linux-mnt-reform-headers')
pkgver=6.18.16
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
  '84b3b876897bfc5f38318909b9e1d6189878acfa57cb3ce0f54d0d3c274e3e28'
  'ebf52803cf900bf67df197abf55f6d850009d81fe3e3c5a27daecdbe32bfc924'
  'b83bfbb4eea8d7186d52f1157966e6761e2a159799a8b2bc84677b2624aeea9c'
  'ff6aeb3704c23e690dbf975602266fa03a8c0c532808bd7d0af9eb05e4afd3ad'
  '2ced29f2a09d2e3d240872bf7c95324dc52fe952bfc7b0a0887c795c82fb2b18'
)

build() {
  :
}

package_linux-mnt-reform() {
  pkgdesc='Linux kernel for MNT Reform (arm64)'
  depends=('dracut' 'kmod' 'cpio')
  optdepends=('linux-mnt-reform-headers: for building modules')
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
