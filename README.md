This repo is for review of requests for signing shim.  To create a request for review:

- clone this repo
- edit the template below
- add the shim.efi to be signed
- add build logs
- add any additional binaries/certificates/SHA256 hashes that may be needed
- commit all of that
- tag it with a tag of the form "myorg-shim-arch-YYYYMMDD"
- push that to github
- file an issue at https://github.com/rhboot/shim-review/issues with a link to your branch
- approval is ready when you have accepted tag

Note that we really only have experience with using GRUB2 on Linux, so asking
us to endorse anything else for signing is going to require some convincing on
your part.

Here's the template:

-------------------------------------------------------------------------------
What organization or people are asking to have this signed:
-------------------------------------------------------------------------------
Microsoft Corporation

-------------------------------------------------------------------------------
What product or service is this for:
-------------------------------------------------------------------------------
CBL-Mariner

-------------------------------------------------------------------------------
What's the justification that this really does need to be signed for the whole world to be able to boot it:
-------------------------------------------------------------------------------
CBL-Mariner is an Linux distribution, built to run first party Azure cloud and edge workloads.

-------------------------------------------------------------------------------
Who is the primary contact for security updates, etc.
-------------------------------------------------------------------------------
- Name: Jim Perrin
- Position: Principal Program Manager – Linux Systems Group
- Email address: jim.perrin@microsoft.com
- PGP key, signed by the other security contacts, and preferably also with signatures that are reasonably well known in the linux community: [jperrin.pub](jperrin.pub)

-------------------------------------------------------------------------------
Who is the secondary contact for security updates, etc.
-------------------------------------------------------------------------------
- Name: Christopher Co
- Position: Senior Software Engineer
- Email address: christopher.co@microsoft.com
- PGP key, signed by the other security contacts, and preferably also with signatures that are reasonably well known in the linux community: N/A

-------------------------------------------------------------------------------
Please create your shim binaries starting with the 15.4 shim release tar file:
https://github.com/rhboot/shim/releases/download/15.4/shim-15.4.tar.bz2

This matches https://github.com/rhboot/shim/releases/tag/15.4 and contains
the appropriate gnu-efi source.
-------------------------------------------------------------------------------
Confirmed. We are building from the shim-15.4 tar file.

-------------------------------------------------------------------------------
URL for a repo that contains the exact code which was built to get this binary:
-------------------------------------------------------------------------------
Source RPM included in this repo - [shim-unsigned-x64-15.4-1.cm1.src.rpm](shim-unsigned-x64-15.4-1.cm1.src.rpm)

-------------------------------------------------------------------------------
What patches are being applied and why:
-------------------------------------------------------------------------------
No additional patches applied.

-------------------------------------------------------------------------------
If bootloader, shim loading is, GRUB2: is CVE-2020-14372, CVE-2020-25632,
 CVE-2020-25647, CVE-2020-27749, CVE-2020-27779, CVE-2021-20225, CVE-2021-20233,
 CVE-2020-10713, CVE-2020-14308, CVE-2020-14309, CVE-2020-14310, CVE-2020-14311,
 CVE-2020-15705, and if you are shipping the shim_lock module CVE-2021-3418
-------------------------------------------------------------------------------
Yes. Our GRUB2 is baselined on 2.06-rc1 which has these fixes.

-------------------------------------------------------------------------------
What exact implementation of Secureboot in GRUB2 ( if this is your bootloader ) you have ?
* Upstream GRUB2 shim_lock verifier or * Downstream RHEL/Fedora/Debian/Canonical like implementation ?
-------------------------------------------------------------------------------
Baseline is Grub 2.06-rc1 + Secure Boot patches from Fedora 34 + a few extra patches from Fedora 34

Our latest Grub2 spec and patches can be found here: https://github.com/microsoft/CBL-Mariner/tree/1.0-dev/SPECS/grub2

The current grub2 source RPM is also provided in this repository: [grub2-2.06~rc1-1.cm1.src.rpm](grub2-2.06~rc1-1.cm1.src.rpm)

-------------------------------------------------------------------------------
If bootloader, shim loading is, GRUB2, and previous shims were trusting affected
by CVE-2020-14372, CVE-2020-25632, CVE-2020-25647, CVE-2020-27749,
  CVE-2020-27779, CVE-2021-20225, CVE-2021-20233, CVE-2020-10713,
  CVE-2020-14308, CVE-2020-14309, CVE-2020-14310, CVE-2020-14311, CVE-2020-15705,
  and if you were shipping the shim_lock module CVE-2021-3418
  ( July 2020 grub2 CVE list + March 2021 grub2 CVE list )
  grub2:
* were old shims hashes provided to Microsoft for verification
  and to be added to future DBX update ?
* Does your new chain of trust disallow booting old, affected by CVE-2020-14372,
  CVE-2020-25632, CVE-2020-25647, CVE-2020-27749,
  CVE-2020-27779, CVE-2021-20225, CVE-2021-20233, CVE-2020-10713,
  CVE-2020-14308, CVE-2020-14309, CVE-2020-14310, CVE-2020-14311, CVE-2020-15705,
  and if you were shipping the shim_lock module CVE-2021-3418
  ( July 2020 grub2 CVE list + March 2021 grub2 CVE list )
  grub2 builds ?
-------------------------------------------------------------------------------
* No previous shims signed by the Microsoft UEFI CA.
* We have a new signing key for grub2. We did not sign any grub2 builds affected by these CVEs with this new key. Our signed grub2 builds have the CVE fixes.

-------------------------------------------------------------------------------
If your boot chain of trust includes linux kernel, is
"efi: Restrict efivar_ssdt_load when the kernel is locked down"
upstream commit 1957a85b0032a81e6482ca4aab883643b8dae06e applied ?
Is "ACPI: configfs: Disallow loading ACPI tables when locked down"
upstream commit 75b0cea7bf307f362057cc778efe89af4c615354 applied ?
-------------------------------------------------------------------------------
Yes, these commits are present in our linux kernel. We are baselined on 5.10 LTS stable tree.
Source tree here: https://github.com/microsoft/CBL-Mariner-Linux-Kernel/tree/rolling-lts/mariner/5.10.21.1
- https://github.com/microsoft/CBL-Mariner-Linux-Kernel/commit/824d0b6225f3fa2992704478a8df520537cfcb56
- https://github.com/microsoft/CBL-Mariner-Linux-Kernel/commit/1957a85b0032a81e6482ca4aab883643b8dae06e
-------------------------------------------------------------------------------
If you use vendor_db functionality of providing multiple certificates and/or
hashes please briefly describe your certificate setup. If there are allow-listed hashes
please provide exact binaries for which hashes are created via file sharing service,
available in public with anonymous access for verification
-------------------------------------------------------------------------------
Not used.

-------------------------------------------------------------------------------
If you are re-using a previously used (CA) certificate, you will need
to add the hashes of the previous GRUB2 binaries to vendor_dbx in shim
in order to prevent GRUB2 from being able to chainload those older GRUB2
binaries. If you are changing to a new (CA) certificate, this does not
apply. Please describe your strategy.
-------------------------------------------------------------------------------
We changed to a new certificate.

-------------------------------------------------------------------------------
What OS and toolchain must we use to reproduce this build?  Include where to find it, etc.  We're going to try to reproduce your build as close as possible to verify that it's really a build of the source tree you tell us it is, so these need to be fairly thorough. At the very least include the specific versions of gcc, binutils, and gnu-efi which were used, and where to find those binaries.
If possible, provide a Dockerfile that rebuilds the shim.
-------------------------------------------------------------------------------
Build is done in a CBL-Mariner build environment. Build can be replicated with
the provided docker base image ([core-1.0.20210224.tar.gz](core-1.0.20210224.tar.gz))
and shim source rpm ([shim-unsigned-x64-15.4-1.cm1.src.rpm](shim-unsigned-x64-15.4-1.cm1.src.rpm))

Relevant sha256 hashes:
```
d18d126e1bafd11a5b83b647fb19cad98b122dcc8002bbf85bb7239816a22ef8  core-1.0.20210224.tar.gz
c51ec973d5639fd96ade396342acff400a064af2f4765ad41e46297c4e8cbdf3  shim-unsigned-x64-15.4-1.cm1.src.rpm
8344473dd10569588b8238a4656b8fab226714eea9f5363f8c410aa8a5090297  shim-15.4.tar.bz2
4930a1506341f7a37f4f22dd284d90e64bb4fb99ca8ee634b10ee52951e3604f  shimx64.efi
5409e795dd63fb962edb0ac753ec1241a5af3fa6a0b622b8a69743e14ddaac91  Dockerfile
```

A Dockerfile ([Dockerfile](Dockerfile)) is provided to reproduce the entire build
using the provided docker base image and source rpm.
```
cd shim-review
docker import core-1.0.20210224.tar.gz cbl-mariner-1.0
docker build -t cbl-mariner-1.0-shim-review .
```

-------------------------------------------------------------------------------
Which files in this repo are the logs for your build?   This should include logs for creating the buildroots, applying patches, doing the build, creating the archives, etc.
-------------------------------------------------------------------------------
Build logs: [shim-unsigned-x64-15.4-1.cm1.src.rpm.log](shim-unsigned-x64-15.4-1.cm1.src.rpm.log)

Docker logs: [docker.log](docker.log)

-------------------------------------------------------------------------------
Add any additional information you think we may need to validate this shim
-------------------------------------------------------------------------------
