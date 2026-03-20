# Maintainer: Stephano Cetola <stephanoc@gmail.com>

pkgbase=linux-mnt-reform-bin
pkgname=('linux-mnt-reform-bin' 'linux-mnt-reform-bin-headers')
pkgver=6.19.9
pkgrel=1
_kernver="${pkgver}-mnt-reform"
arch=('aarch64')
url="https://github.com/cetola/mnt-build"
license=('GPL-2.0-only')
options=(!strip !docs !emptydirs)
source=(
  "kernel-${pkgver}-${pkgrel}-mnt.tar.gz::https://github.com/cetola/mnt-build/releases/download/${pkgver}-${pkgrel}-mnt-reform/kernel-${pkgver}-${pkgrel}-mnt.tar.gz"
  "headers-${pkgver}-${pkgrel}-mnt.tar.gz::https://github.com/cetola/mnt-build/releases/download/${pkgver}-${pkgrel}-mnt-reform/headers-${pkgver}-${pkgrel}-mnt.tar.gz"
  'extlinux.conf.example'
  'mnt-reform-initramfs.hook'
  'mnt-reform-initramfs.sh'
)
sha256sums=(
  '2bf5498d7f839a0163445f06fd864310cbf7f9878a26a3fb6c1718488b7cfba1'
  '503609e9458ece449d20f6ce6a7dd0c497417c17f728f568c11851d0da4cd6bc'
  'b83bfbb4eea8d7186d52f1157966e6761e2a159799a8b2bc84677b2624aeea9c'
  '24e36fc74f7aa27fe699e5eac923c14ae80c7bc85038cfab3d8cd93148d7cb3e'
  '2ced29f2a09d2e3d240872bf7c95324dc52fe952bfc7b0a0887c795c82fb2b18'
)

build() {
  :
}

package_linux-mnt-reform-bin() {
  pkgdesc='Linux kernel for MNT Reform (arm64)'
  depends=('coreutils' 'dracut' 'kmod' 'cpio')
  optdepends=('linux-mnt-reform-bin-headers: for building modules')
  provides=("linux=${pkgver}")
  conflicts=('linux')
  install='linux-mnt-reform-bin.install'

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
    "$pkgdir/usr/share/doc/linux-mnt-reform-bin/extlinux.conf.example"

  install -Dm644 "$srcdir/mnt-reform-initramfs.hook" \
    "$pkgdir/usr/share/libalpm/hooks/mnt-reform-initramfs.hook"

  install -Dm755 "$srcdir/mnt-reform-initramfs.sh" \
    "$pkgdir/usr/lib/linux-mnt-reform-bin/mnt-reform-initramfs.sh"
}

package_linux-mnt-reform-bin-headers() {
  pkgdesc='Header files and scripts for building modules for linux-mnt-reform-bin kernel'
  depends=('perl' "linux-mnt-reform-bin=${pkgver}-${pkgrel}")
  provides=("linux-headers=${pkgver}")
  conflicts=('linux-mnt-reform-headers')

  cd "$srcdir/linux-${pkgver}"

  install -dm755 "$pkgdir/usr/lib/modules/${_kernver}/build"
  echo 'Installing pre-prepared kernel headers...'
  cp -a . "$pkgdir/usr/lib/modules/${_kernver}/build"
}
