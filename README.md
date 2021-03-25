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
- PGP key fingerprint: 3BD6E132BCA05F39723DEC6216C7C82EFA09AD77 - [jperrin.pub](jperrin.pub)
  
(Key should be signed by the other security contacts, pushed to a keyserver
like keyserver.ubuntu.com, and preferably have signatures that are reasonably
well known in the Linux community.)

-------------------------------------------------------------------------------
Who is the secondary contact for security updates, etc.
-------------------------------------------------------------------------------
- Name: Christopher Co
- Position: Senior Software Engineer
- Email address: chrco@microsoft.com
- PGP key fingerprint: 1C93B28D06DF5109C9AE7DA3482FA57851707C54 - [chrco.pub](chrco.pub)

(Key should be signed by the other security contacts, pushed to a keyserver
like keyserver.ubuntu.com, and preferably have signatures that are reasonably
well known in the Linux community.)

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
Source RPM included in this repo - [shim-unsigned-x64-15.4-2.cm1.src.rpm](shim-unsigned-x64-15.4-2.cm1.src.rpm)

-------------------------------------------------------------------------------
What patches are being applied and why:
-------------------------------------------------------------------------------
We are applying these patches to fix critical regressions in shim 15.4:

- https://github.com/rhboot/shim/pull/364
- https://github.com/rhboot/shim/commit/822d07ad4f07ef66fe447a130e1027c88d02a394
- https://github.com/rhboot/shim/pull/357
- https://github.com/rhboot/shim/pull/372
- https://github.com/rhboot/shim/pull/379
- https://github.com/rhboot/shim/pull/361

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

Our latest Grub2 spec and patches can be found here: https://github.com/microsoft/CBL-Mariner/tree/1.0/SPECS/grub2

The current grub2 source RPM is also provided in this repository: [grub2-2.06~rc1-5.cm1.src.rpm](grub2-2.06~rc1-5.cm1.src.rpm)

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
* Not applicable. Our only previously signed shim did not trust any GRUB2 affected by the listed CVEs.
* We did not sign any grub2 builds affected by these CVEs with key trusted by any of our previously signed shims. Our signed grub2 builds have the CVE fixes.

-------------------------------------------------------------------------------
If your boot chain of trust includes linux kernel, is
"efi: Restrict efivar_ssdt_load when the kernel is locked down"
upstream commit 1957a85b0032a81e6482ca4aab883643b8dae06e applied ?
Is "ACPI: configfs: Disallow loading ACPI tables when locked down"
upstream commit 75b0cea7bf307f362057cc778efe89af4c615354 applied ?
-------------------------------------------------------------------------------
Yes, these commits are present in our linux kernel. We are baselined on 5.10 LTS stable tree.
Source tree here: https://github.com/microsoft/CBL-Mariner-Linux-Kernel/tree/rolling-lts/mariner/5.10.78.1
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
If the shim binaries can't be reproduced using the provided Dockerfile, please explain why that's the case and what the differences would be.
-------------------------------------------------------------------------------
Build is done in a CBL-Mariner build environment. Build can be replicated with
the provided [Dockerfile](Dockerfile).
```
cd shim-review
docker build -t cbl-mariner-1.0-shim-review .
```

Relevant sha256 hashes:
```
1ee3189f2e48213346bbabb512cba893d18758f429142e42df6f24ac2feef5cb  shim-unsigned-x64-15.4-2.cm1.src.rpm
8344473dd10569588b8238a4656b8fab226714eea9f5363f8c410aa8a5090297  shim-15.4.tar.bz2
fb83a52ebab42540d43d59fada0a4d9fe929a2a9b749f7cad89a7607124c04e0  shimx64.efi
68419cc5d3c71cbbff3aefeebfad8a1f76fd712b065f4fdaea4c1f5e55bdf2be  Dockerfile
```

-------------------------------------------------------------------------------
Which files in this repo are the logs for your build?   This should include logs for creating the buildroots, applying patches, doing the build, creating the archives, etc.
-------------------------------------------------------------------------------
Build logs: [shim-unsigned-x64-15.4-2.cm1.src.rpm.log](shim-unsigned-x64-15.4-2.cm1.src.rpm.log)

Docker logs: [docker.log](docker.log)

-------------------------------------------------------------------------------
Add any additional information you think we may need to validate this shim
-------------------------------------------------------------------------------
Link to our previously accepted 15.4 submission - https://github.com/rhboot/shim-review/issues/150