This repo is for review of requests for signing shim.  To create a request for review:

- clone this repo
- edit the template below
- add the shim.efi to be signed
- add build logs
- add any additional binaries/certificates/hashes that may be needed
- commit all of that
- tag it with a tag of the form "myorg-shim-arch-YYYYMMDD"
- push that to github
- file an issue at https://github.com/rhboot/shim-review/issues with a link to your branch
- approval is ready when you have accepted tag

Note that we really only have experience with using grub2 on Linux, so asking
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
What upstream shim tag is this starting from:
-------------------------------------------------------------------------------
Upstream shim-15 release - https://github.com/rhboot/shim/releases/tag/15

-------------------------------------------------------------------------------
URL for a repo that contains the exact code which was built to get this binary:
-------------------------------------------------------------------------------
Source RPM included in this repo - [shim-unsigned-x64-15-6.cm1.src.rpm](shim-unsigned-x64-15-6.cm1.src.rpm)

-------------------------------------------------------------------------------
What patches are being applied and why:
-------------------------------------------------------------------------------
All 63 patches from most recent Centos7 shim package (shim-15-8.el7) are included.

-------------------------------------------------------------------------------
If bootloader, shim loading is, grub2: is CVE-2020-10713 fixed ?
-------------------------------------------------------------------------------
Yes

-------------------------------------------------------------------------------
If bootloader, shim loading is, grub2, and previous shims were trusting affected
by CVE-2020-10713 grub2:
* were old shims hashes provided to Microsoft for verification
  and to be added to future DBX update ?
* Does your new chain of trust disallow booting old, affected by CVE-2020-10713,
  grub2 builds ?
-------------------------------------------------------------------------------

* N/A - This is our first shim submission.

* We did not sign any grub2 builds affected by the CVE. Our signed grub2 builds have the CVE fix.

-------------------------------------------------------------------------------
If your boot chain of trust includes linux kernel, is
"efi: Restrict efivar_ssdt_load when the kernel is locked down"
upstream commit 1957a85b0032a81e6482ca4aab883643b8dae06e applied ?
Is "ACPI: configfs: Disallow loading ACPI tables when locked down"
upstream commit 75b0cea7bf307f362057cc778efe89af4c615354 applied ?
-------------------------------------------------------------------------------
Yes, these commits are present in our linux kernel (baselined on 5.4.51 stable tree)
Source tree here: https://github.com/microsoft/WSL2-Linux-Kernel/tree/linux-msft-5.4.51

-------------------------------------------------------------------------------
If you use vendor_db functionality of providing multiple certificates and/or
hashes please briefly describe your certificate setup. If there are whitelisted hashes
please provide exact binaries for which hashes are created via file sharing service,
available in public with anonymous access for verification
-------------------------------------------------------------------------------
Not used.

-------------------------------------------------------------------------------
What OS and toolchain must we use to reproduce this build?  Include where to find it, etc.  We're going to try to reproduce your build as close as possible to verify that it's really a build of the source tree you tell us it is, so these need to be fairly thorough. At the very least include the specific versions of gcc, binutils, and gnu-efi which were used, and where to find those binaries.
If possible, provide a Dockerfile that rebuilds the shim.
-------------------------------------------------------------------------------
Build is done in a CBL-Mariner build environment. Build can be replicated with
the provided docker base image ([core-container.tar.gz](core-container.tar.gz))
and shim source rpm ([shim-unsigned-x64-15-6.cm1.src.rpm](shim-unsigned-x64-15-6.cm1.src.rpm))

Relevant sha256 hashes:
```
cdd1a79f47947f894f153109f3ac39e45ec943b61462e1fb7d68e86d4842f9c9  core-container.tar.gz
695f19324ba812501537bc63cb16b992263c66365399dc3b41287d21dd25e3c6  shim-unsigned-x64-15-6.cm1.src.rpm
473720200e6dae7cfd3ce7fb27c66367a8d6b08233fe63f01aa1d6b3888deeb6  shim-15.tar.bz2
912772f957c4b65948f138815c8f525ef22039dc222b94842958e92fa3c86619  shimx64.efi
ee52d5377873cd0ed33d1d0b54d49cb78c68886e6d2479c576a10c7067eedb8a  Dockerfile
```

A Dockerfile ([Dockerfile](Dockerfile)) is provided to reproduce the entire build
using the provided docker base image and source rpm.
```
cd shim-review
docker import core-container.tar.gz cbl-mariner-1.0
docker build -t cbl-mariner-1.0-shim-review .
```

-------------------------------------------------------------------------------
Which files in this repo are the logs for your build?   This should include logs for creating the buildroots, applying patches, doing the build, creating the archives, etc.
-------------------------------------------------------------------------------
Build logs: [build.log](build.log)
Docker logs: [docker.log](docker.log)

-------------------------------------------------------------------------------
Add any additional information you think we may need to validate this shim
-------------------------------------------------------------------------------
