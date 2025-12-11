# Maintainer: Stephano Cetola <stephanoc@gmail.com>

pkgname=linux-mnt-pocket
pkgver=6.17.11
pkgrel=1
_kernver="${pkgver}-mnt-pocket"
pkgdesc="Linux kernel for MNT Pocket Reform (arm64)"
arch=('aarch64')
url="https://github.com/cetola/mnt-build"
license=('GPL2')
depends=('dracut' 'kmod')
provides=('linux' 'linux-aarch64')
conflicts=('linux')
backup=('etc/modprobe.d/reform-qcacld2.conf')
source=(
  "kernel-${pkgver}-${pkgrel}-mnt.tar.gz::https://github.com/cetola/mnt-build/releases/download/${pkgver}-${pkgrel}-mnt-pocket/kernel-${pkgver}-${pkgrel}-mnt.tar.gz"
  "extlinux.conf.example"
  "mnt-pocket-initramfs.hook"
  "mnt-pocket-backup.hook"
  "mnt-pocket-backup.sh"
)
sha256sums=(
  '4f5850583160be1b5131cff08390b1234cebb3644eb085dbfcc512d578b9bb7d'
  '672b1922a43856cb6466354a1b2432c7cf8dedfa3da25c8e59a1a0dcb0c7a83e'
  '4710c4556ee94d7264211093db1f3f3368e5fd3e100f3ed81006f7041acc64bf'
  'SKIP'
)

options=(!strip !docs !emptydirs)

package() {
  cd "$srcdir"

  install -dm755 "$pkgdir/usr/lib/modules/${_kernver}"
  cp -r lib/modules/${_kernver}/* "$pkgdir/usr/lib/modules/${_kernver}/"

  install -Dm644 reform2_lpc.ko "$pkgdir/usr/lib/modules/${_kernver}/extra/reform2_lpc.ko"
  install -Dm644 wlan.ko        "$pkgdir/usr/lib/modules/${_kernver}/extra/wlan.ko"

  install -dm755 "$pkgdir/usr/lib/firmware/qcacld2"
  install -Dm644 usr/lib/firmware/qcacld2/* "$pkgdir/usr/lib/firmware/qcacld2/"

  install -dm755 "$pkgdir/usr/lib/firmware/wlan/qcacld2"
  install -Dm644 usr/lib/firmware/wlan/qcacld2/* "$pkgdir/usr/lib/firmware/wlan/qcacld2/"

  install -Dm644 etc/modprobe.d/reform-qcacld2.conf \
    "$pkgdir/etc/modprobe.d/reform-qcacld2.conf"

  install -Dm644 arch/arm64/boot/Image \
    "$pkgdir/boot/Image-${pkgname}"

  install -Dm644 "imx8mp-mnt-pocket-reform-${pkgver}.dtb" \
    "$pkgdir/boot/imx8mp-mnt-pocket-reform.dtb"

  install -Dm644 "$srcdir/extlinux.conf.example" \
    "$pkgdir/usr/share/doc/${pkgname}/extlinux.conf.example"

  install -Dm644 "$srcdir/mnt-pocket-initramfs.hook" \
    "$pkgdir/usr/share/libalpm/hooks/mnt-pocket-initramfs.hook"

  install -Dm644 "$srcdir/mnt-pocket-backup.hook" \
    "$pkgdir/usr/share/libalpm/hooks/mnt-pocket-backup.hook"

  install -Dm755 "$srcdir/mnt-pocket-backup.sh" \
    "$pkgdir/usr/bin/mnt-pocket-backup.sh"
}

