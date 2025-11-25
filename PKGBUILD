# Maintainer: Your Name <your.email@example.com>
pkgname=linux-mnt-pocket
pkgver=6.17.9
_kernver="${pkgver}-dirty"
pkgrel=1
pkgdesc="Linux kernel for MNT Pocket Reform (arm64)"
arch=('aarch64')
url="https://github.com/cetola/mnt-build"
license=('GPL2')
depends=('dracut' 'kmod')
provides=('linux-aarch64' 'linux')
conflicts=('linux')
backup=('etc/modprobe.d/reform-qcacld2.conf')
install="${pkgname}.install"
source=("https://github.com/cetola/mnt-build/releases/download/${pkgver}-${pkgrel}-mnt-pocket/kernel-${pkgver}-${pkgrel}-mnt.tar.gz"
        "extlinux.conf.example")
sha256sums=('5022cd1e4b1de08dd6c9e83b63a549415d2039864543105f167acb9500c93c0a'
            '672b1922a43856cb6466354a1b2432c7cf8dedfa3da25c8e59a1a0dcb0c7a83e')
options=(!strip !docs !libtool !staticlibs !emptydirs)

package() {
  cd "${srcdir}"
  
  # Install kernel modules
  install -dm755 "${pkgdir}/usr/lib/modules/${_kernver}"
  cp -r lib/modules/${_kernver}/* "${pkgdir}/usr/lib/modules/${_kernver}/"
  
  # Install extra modules
  install -dm755 "${pkgdir}/usr/lib/modules/${_kernver}/extra"
  install -Dm644 reform2_lpc.ko "${pkgdir}/usr/lib/modules/${_kernver}/extra/"
  install -Dm644 wlan.ko "${pkgdir}/usr/lib/modules/${_kernver}/extra/"
  
  # Install firmware
  install -dm755 "${pkgdir}/usr/lib/firmware/qcacld2"
  install -Dm644 usr/lib/firmware/qcacld2/* "${pkgdir}/usr/lib/firmware/qcacld2/"
  
  install -dm755 "${pkgdir}/usr/lib/firmware/wlan/qcacld2"
  install -Dm644 usr/lib/firmware/wlan/qcacld2/* "${pkgdir}/usr/lib/firmware/wlan/qcacld2/"
  
  # Install modprobe config
  install -Dm644 etc/modprobe.d/reform-qcacld2.conf "${pkgdir}/etc/modprobe.d/reform-qcacld2.conf"
  
  # Install kernel image
  install -dm755 "${pkgdir}/boot"
  install -Dm644 arch/arm64/boot/Image "${pkgdir}/boot/Image-${pkgname}"
  
  # Install device tree blob
  install -Dm644 imx8mp-mnt-pocket-reform-${pkgver}.dtb "${pkgdir}/boot/imx8mp-mnt-pocket-reform.dtb"
  
  # Install example extlinux config
  install -Dm644 "${srcdir}/extlinux.conf.example" "${pkgdir}/usr/share/doc/${pkgname}/extlinux.conf.example"
  
}
