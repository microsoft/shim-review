FROM mcr.microsoft.com/cbl-mariner/base/core:2.0.20240123
RUN tdnf install -y binutils-2.37-7.cm2 \
                    dos2unix-7.4.2-1.cm2 \
                    efivar-devel-37-6.cm2 \
                    gcc-11.2.0-7.cm2 \
                    make-4.3-3.cm2 \
                    glibc-devel-2.35-6.cm2 \
                    kernel-headers-5.15.145.2-1.cm2 \
                    rpm-build-4.18.0-4.cm2 \
                    vim-extra-9.0.2121-1.cm2
COPY shim-unsigned-x64-15.8-1.cm2.src.rpm /root/shim-unsigned-x64-15.8-1.cm2.src.rpm
COPY shimx64.efi /
RUN rpm -iv /root/shim-unsigned-x64-15.8-1.cm2.src.rpm
RUN rpmbuild -bb /usr/src/mariner/SPECS/shim-unsigned-x64.spec
RUN rpm -iv /usr/src/mariner/RPMS/x86_64/shim-unsigned-x64-15.8-1.cm2.x86_64.rpm
RUN sha256sum /usr/share/shim-unsigned-x64/shimx64.efi
RUN sha256sum /shimx64.efi
RUN cmp /usr/share/shim-unsigned-x64/shimx64.efi /shimx64.efi
RUN objcopy -O binary -j .sbat /usr/share/shim-unsigned-x64/shimx64.efi /shim-sbat
RUN cat /shim-sbat
