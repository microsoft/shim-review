FROM mcr.microsoft.com/azurelinux/base/core:3.0.20240824
COPY shim-unsigned-*-15.8-3.azl3.src.rpm shim*.efi /

RUN <<-EOF
  set -ex

  export ARCH=$(rpm -E %_arch)
  case $ARCH in
    x86_64)
      PKGNAME=shim-unsigned-x64
      SHIMDIR=/usr/share/shim/15.8/x64
      SHIM=shimx64.efi
      ;;
    aarch64)
      PKGNAME=shim-unsigned-aarch64
      SHIMDIR=/usr/share/shim/15.8/aa64
      SHIM=shimaa64.efi
      ;;
    *)
      echo "Invalid arch: $ARCH"
      false
      ;;
  esac

  tdnf install -y binutils-0:2.41-2.azl3 \
                  dos2unix-0:7.5.1-1.azl3 \
                  efivar-devel-0:39-1.azl3 \
                  gcc-0:13.2.0-7.azl3 \
                  git-0:2.45.2-1.azl3 \
                  glibc-devel-0:2.38-7.azl3 \
                  kernel-headers-0:6.6.47.1-1.azl3 \
                  make-0:4.4.1-1.azl3 \
                  openssl-devel-0:3.3.0-2.azl3 \
                  pesign-0:116-3.azl3 \
                  rpm-build-0:4.18.2-1.azl3 \
                  vim-extra-0:9.0.2190-3.azl3

  rpm -iv /${PKGNAME}-*.src.rpm
  rpmbuild -bb /usr/src/azl/SPECS/${PKGNAME}.spec
  rpm -iv /usr/src/azl/RPMS/${ARCH}/${PKGNAME}-*.${ARCH}.rpm
  sha256sum ${SHIMDIR}/${SHIM} /${SHIM} > /shim.sha256
  cmp ${SHIMDIR}/${SHIM} /${SHIM}
  objcopy -O binary -j .sbat ${SHIMDIR}/${SHIM} /shim-sbat
EOF

RUN cat /shim.sha256
RUN cat /shim-sbat
