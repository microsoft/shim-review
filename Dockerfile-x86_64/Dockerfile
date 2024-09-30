FROM mcr.microsoft.com/azurelinux/base/core:3.0.20240824
COPY shim-unsigned-x64-15.8-3.azl3.src.rpm shimx64.efi /

RUN tdnf install -y binutils-0:2.41-2.azl3 \
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

RUN rpm -iv /shim-unsigned-x64-*.src.rpm
RUN rpmbuild -bb /usr/src/azl/SPECS/shim-unsigned-x64.spec
RUN rpm -iv /usr/src/azl/RPMS/x86_64/shim-unsigned-x64-*.x86_64.rpm
RUN sha256sum /usr/share/shim/15.8/x64/shimx64.efi /shimx64.efi > /shim.sha256
RUN cmp /usr/share/shim/15.8/x64/shimx64.efi /shimx64.efi
RUN objcopy -O binary -j .sbat /usr/share/shim/15.8/x64/shimx64.efi /shim-sbat

RUN cat /shim.sha256
RUN cat /shim-sbat
