FROM cbl-mariner-1.0:latest
RUN tdnf install -y rpm-build gcc make gnu-efi gnu-efi-devel binutils cpio patch diffutils
COPY shim-unsigned-x64-15-6.cm1.src.rpm /root/shim-unsigned-x64-15-6.cm1.src.rpm
COPY shimx64.efi /
COPY shim-15.tar.bz2 /
RUN sha256sum /root/shim-unsigned-x64-15-6.cm1.src.rpm
RUN rpm -ihv /root/shim-unsigned-x64-15-6.cm1.src.rpm
RUN sha256sum /usr/src/mariner/SOURCES/shim-15.tar.bz2
RUN sha256sum /shim-15.tar.bz2
RUN rpmbuild -bb /usr/src/mariner/SPECS/shim-unsigned-x64.spec 2>&1 | tee /build.log
RUN rpm -qlp /usr/src/mariner/RPMS/x86_64/shim-unsigned-x64-15-6.x86_64.rpm
RUN rpm2cpio /usr/src/mariner/RPMS/x86_64/shim-unsigned-x64-15-6.x86_64.rpm | cpio -idmv
RUN sha256sum /usr/share/shim-unsigned-x64/shimx64.efi
RUN sha256sum /shimx64.efi
RUN hexdump -Cv /usr/share/shim-unsigned-x64/shimx64.efi > /built.hex
RUN hexdump -Cv /shimx64.efi > /orig.hex
RUN diff -u /orig.hex /built.hex || true