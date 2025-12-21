# Maintainer: Stephano Cetola <stephanoc@gmail.com>

pkgname=linux-mnt-pocket
pkgver=6.18.2
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
install="${pkgname}.install"
source=(
  "kernel-${pkgver}-${pkgrel}-mnt.tar.gz::https://github.com/cetola/mnt-build/releases/download/${pkgver}-${pkgrel}-mnt-pocket/kernel-${pkgver}-${pkgrel}-mnt.tar.gz"
  "extlinux.conf.example"
  "mnt-pocket-initramfs.hook"
  "mnt-pocket-initramfs.sh"
)
sha256sums=(
  '09bca36db74115829b8a3d9c29a0df815bcf01339c24059f415097b9993c41ea'
  '38fced8cce1d1c175c7a81b522af2ecdaee94735aa48aa4e9a29b75d2d75bd49'
  '4a799cdb15bb62469056daccbb6465de5477eb0128f0430608e0e4b99b651eba'
  'ee36d2090bfc55e3fddfdfba7767a6af1cbd294ab421a5a10d43757290fb5e58'
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

  install -Dm755 "$srcdir/mnt-pocket-initramfs.sh" \
    "$pkgdir/usr/lib/linux-mnt-pocket/mnt-pocket-initramfs.sh"
}

