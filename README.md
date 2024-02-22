This repo is for review of requests for signing shim.  To create a request for review:

- clone this repo
- edit the template below
- add the shim.efi to be signed
- add build logs
- add any additional binaries/certificates/SHA256 hashes that may be needed
- commit all of that
- tag it with a tag of the form "myorg-shim-arch-YYYYMMDD"
- push that to github
- file an issue at https://github.com/rhboot/shim-review/issues with a link to your tag
- approval is ready when the "accepted" label is added to your issue

Note that we really only have experience with using GRUB2 or systemd-boot on Linux, so
asking us to endorse anything else for signing is going to require some convincing on
your part.

Check the docs directory in this repo for guidance on submission and
getting your shim signed.

Here's the template:

*******************************************************************************
### What organization or people are asking to have this signed?
*******************************************************************************

Microsoft

*******************************************************************************
### What product or service is this for?
*******************************************************************************

Microsoft Azure Linux

*******************************************************************************
### What's the justification that this really does need to be signed for the whole world to be able to boot it?
*******************************************************************************

Our distribution must run under secure boot on the Azure cloud, as well as other hosts including bare metal systems

*******************************************************************************
### Why are you unable to reuse shim from another distro that is already signed?
*******************************************************************************

We are a full distro that maintains and regularly releases updated grub and kernel packages.

*******************************************************************************
### Who is the primary contact for security updates, etc.?
The security contacts need to be verified before the shim can be accepted. For subsequent requests, contact verification is only necessary if the security contacts or their PGP keys have changed since the last successful verification.

An authorized reviewer will initiate contact verification by sending each security contact a PGP-encrypted email containing random words.
You will be asked to post the contents of these mails in your `shim-review` issue to prove ownership of the email addresses and PGP keys.
*******************************************************************************
- Name: Dan Streetman
- Position: Engineer
- Email address: ddstreet@microsoft.com
- PGP key fingerprint: CF30 0560 12E9 22A2 5BF0  D113 CFA5 4A80 956B AF5D

(Key should be signed by the other security contacts, pushed to a keyserver
like keyserver.ubuntu.com, and preferably have signatures that are reasonably
well known in the Linux community.)

*******************************************************************************
### Who is the secondary contact for security updates, etc.?
*******************************************************************************
- Name: Christopher Co
- Position: Engineering Lead
- Email address: chrco@linux.microsoft.com
- PGP key fingerprint: 1C93 B28D 06DF 5109 C9AE  7DA3 482F A578 5170 7C54

(Key should be signed by the other security contacts, pushed to a keyserver
like keyserver.ubuntu.com, and preferably have signatures that are reasonably
well known in the Linux community.)

*******************************************************************************
### Were these binaries created from the 15.8 shim release tar?
Please create your shim binaries starting with the 15.8 shim release tar file: https://github.com/rhboot/shim/releases/download/15.8/shim-15.8.tar.bz2

This matches https://github.com/rhboot/shim/releases/tag/15.8 and contains the appropriate gnu-efi source.

*******************************************************************************

yes

*******************************************************************************
### URL for a repo that contains the exact code which was built to get this binary:
*******************************************************************************

https://github.com/microsoft/CBL-Mariner/tree/ddstreet/shim2

Specifically:
https://github.com/microsoft/CBL-Mariner/tree/ddstreet/shim2/SPECS/shim-unsigned-x64

*******************************************************************************
### What patches are being applied and why:
*******************************************************************************

No patches are being applied to the shim

*******************************************************************************
### Do you have the NX bit set in your shim? If so, is your entire boot stack NX-compatible and what testing have you done to ensure such compatibility?

See https://techcommunity.microsoft.com/t5/hardware-dev-center/nx-exception-for-shim-community/ba-p/3976522 for more details on the signing of shim without NX bit.
*******************************************************************************

No

*******************************************************************************
### If shim is loading GRUB2 bootloader what exact implementation of Secureboot in GRUB2 do you have? (Either Upstream GRUB2 shim_lock verifier or Downstream RHEL/Fedora/Debian/Canonical-like implementation)
*******************************************************************************

GRUB2 2.06 + Secure Boot patches from Fedora 34.

*******************************************************************************
### If shim is loading GRUB2 bootloader and your previously released shim booted a version of GRUB2 affected by any of the CVEs in the July 2020, the March 2021, the June 7th 2022, the November 15th 2022, or 3rd of October 2023 GRUB2 CVE list, have fixes for all these CVEs been applied?

* 2020 July - BootHole
  * Details: https://lists.gnu.org/archive/html/grub-devel/2020-07/msg00034.html
  * CVE-2020-10713
  * CVE-2020-14308
  * CVE-2020-14309
  * CVE-2020-14310
  * CVE-2020-14311
  * CVE-2020-15705
  * CVE-2020-15706
  * CVE-2020-15707
* March 2021
  * Details: https://lists.gnu.org/archive/html/grub-devel/2021-03/msg00007.html
  * CVE-2020-14372
  * CVE-2020-25632
  * CVE-2020-25647
  * CVE-2020-27749
  * CVE-2020-27779
  * CVE-2021-3418 (if you are shipping the shim_lock module)
  * CVE-2021-20225
  * CVE-2021-20233
* June 2022
  * Details: https://lists.gnu.org/archive/html/grub-devel/2022-06/msg00035.html, SBAT increase to 2
  * CVE-2021-3695
  * CVE-2021-3696
  * CVE-2021-3697
  * CVE-2022-28733
  * CVE-2022-28734
  * CVE-2022-28735
  * CVE-2022-28736
  * CVE-2022-28737
* November 2022
  * Details: https://lists.gnu.org/archive/html/grub-devel/2022-11/msg00059.html, SBAT increase to 3
  * CVE-2022-2601
  * CVE-2022-3775
* October 2023 - NTFS vulnerabilities
  * Details: https://lists.gnu.org/archive/html/grub-devel/2023-10/msg00028.html, SBAT increase to 4
  * CVE-2023-4693
  * CVE-2023-4692
*******************************************************************************

We use grub-2.06 as our base, which includes all listed CVEs from July 2020 and March 2021.

We also add patches for:
  * CVE-2021-3695
  * CVE-2021-3696
  * CVE-2021-3697
  * CVE-2022-28733
  * CVE-2022-28734
  * CVE-2022-28735
  * CVE-2022-28736
  * CVE-2022-2601
  * CVE-2022-3775

Note that CVE-2022-28737 is in shim, not grub, and is fixed in the shim 15.8 version we are submitting here.

Our current grub binary does not include patches for CVE-2023-4692 nor CVE-2023-4693; its source package is here:
https://github.com/microsoft/CBL-Mariner/tree/2.0/SPECS/grub2/

However a PR to add those patches, and update our grub to sbat level 4, has been merged here:
https://github.com/microsoft/CBL-Mariner/pull/7906

So the next release of our grub2 rpms will include all the above patches, and will be sbat grub,4

*******************************************************************************
### If shim is loading GRUB2 bootloader, and if these fixes have been applied, is the upstream global SBAT generation in your GRUB2 binary set to 4?
The entry should look similar to: `grub,4,Free Software Foundation,grub,GRUB_UPSTREAM_VERSION,https://www.gnu.org/software/grub/`
*******************************************************************************

As mentioned above, our currently released grub binary has sbat level 'grub,2', but the above-referenced PR has been merged to update to include all patches discussed above and be at sbat level 'grub,4'.

*******************************************************************************
### Were old shims hashes provided to Microsoft for verification and to be added to future DBX updates?
### Does your new chain of trust disallow booting old GRUB2 builds affected by the CVEs?
*******************************************************************************

Our old shim hashes will be provided to Microsoft for inclusion in future DBX updates.

Since all our current and previous grub binaries were set to sbat level 'grub,2' (or lower), our updated shim from this review request will refuse to load them, since it requires sbat level 'grub,4'.

*******************************************************************************
### If your boot chain of trust includes a Linux kernel:
### Is upstream commit [1957a85b0032a81e6482ca4aab883643b8dae06e "efi: Restrict efivar_ssdt_load when the kernel is locked down"](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1957a85b0032a81e6482ca4aab883643b8dae06e) applied?
### Is upstream commit [75b0cea7bf307f362057cc778efe89af4c615354 "ACPI: configfs: Disallow loading ACPI tables when locked down"](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=75b0cea7bf307f362057cc778efe89af4c615354) applied?
### Is upstream commit [eadb2f47a3ced5c64b23b90fd2a3463f63726066 "lockdown: also lock down previous kgdb use"](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=eadb2f47a3ced5c64b23b90fd2a3463f63726066) applied?
*******************************************************************************

Our kernel is based on 5.15 which already includes the first 2 commits.

The last commit was backported into the stable kernel as commit 69c5d307dce15 which was first included in kernel 5.15.42, which we have updated to since our 5.15.45 kernel version release in Oct 2022.

*******************************************************************************
### Do you build your signed kernel with additional local patches? What do they do?
*******************************************************************************

We mainly adhere to the stable kernel release tree for our kernel version (5.15) but also include some additional patches.

Our current kernel tree is here:
https://github.com/microsoft/CBL-Mariner-Linux-Kernel/tree/rolling-lts/mariner-2/5.15.148.2

*******************************************************************************
### Do you use an ephemeral key for signing kernel modules?
### If not, please describe how you ensure that one kernel build does not load modules built for another kernel.
*******************************************************************************

Yes

*******************************************************************************
### If you use vendor_db functionality of providing multiple certificates and/or hashes please briefly describe your certificate setup.
### If there are allow-listed hashes please provide exact binaries for which hashes are created via file sharing service, available in public with anonymous access for verification.
*******************************************************************************

The ESL contains both our current signing certificate, which is expired, as well as our new signing certificate. Including both certificates allows existing signed kernels to continue to be loadable under secure boot.

There are no hashes in the ESL.

We have generated a GUID for Azure Linux to use as the cert owner in the ESL, f4de3b90-399b-4eb0-aa3f-041c434a2de3.

The ESL was generated using the efivar release 39 source tarball, compiled and installed locally, with the command:
$ efisecdb -o db.x64.esl -g 'f4de3b90-399b-4eb0-aa3f-041c434a2de3' -a -c cbl-mariner-ca-20211013.der -c cbl-mariner-ca-20230216.der

*******************************************************************************
### If you are re-using a previously used (CA) certificate, you will need to add the hashes of the previous GRUB2 binaries exposed to the CVEs to vendor_dbx in shim in order to prevent GRUB2 from being able to chainload those older GRUB2 binaries. If you are changing to a new (CA) certificate, this does not apply.
### Please describe your strategy.
*******************************************************************************

While we are re-using our previous certificate, in addition to a new certificate, since all our previous grub binaries were set to sbat level 'grub,2' (or lower) and our new shim requires sbat level 'grub,4', none of our previous signed grub binaries are loadable by the new shim (and since our grub uses shim lock for verification, are not chain-loadable by our grub either) and therefore none of their hashes need to be included in the vendor_dbx.

*******************************************************************************
### What OS and toolchain must we use to reproduce this build?  Include where to find it, etc.  We're going to try to reproduce your build as closely as possible to verify that it's really a build of the source tree you tell us it is, so these need to be fairly thorough. At the very least include the specific versions of gcc, binutils, and gnu-efi which were used, and where to find those binaries.
### If the shim binaries can't be reproduced using the provided Dockerfile, please explain why that's the case and what the differences would be.
*******************************************************************************

This build uses the Microsoft Mariner 2 OS, as detailed in the Dockerfile. The specific image date is specified there, as well as the specific additional package versions to be installed; but the Dockerfile does not specify the specific versions of all additional dependency packages (for the additional packages that are installed using tdnf).

*******************************************************************************
### Which files in this repo are the logs for your build?
This should include logs for creating the buildroots, applying patches, doing the build, creating the archives, etc.
*******************************************************************************

docker-build.log

*******************************************************************************
### What changes were made in the distor's secure boot chain since your SHIM was last signed?
For example, signing new kernel's variants, UKI, systemd-boot, new certs, new CA, etc..
*******************************************************************************

There are 4 kernel variants that we sign, as well as grub2, and one livepatch, as listed here:
https://github.com/microsoft/CBL-Mariner/tree/2.0/SPECS-SIGNED

We have added grub2 CVE patches since the last shim signing.

We do not use systemd-boot or a UKI.

This does introduce a new CA/cert.

*******************************************************************************
### What is the SHA256 hash of your final SHIM binary?
*******************************************************************************

82ede1584e7de1347446a241f09c05cf3efc134206c446be3d548a748e4752e3  shimx64.efi

*******************************************************************************
### How do you manage and protect the keys used in your SHIM?
*******************************************************************************

We use a hardware security module.

*******************************************************************************
### Do you use EV certificates as embedded certificates in the SHIM?
*******************************************************************************

No

*******************************************************************************
### Do you add a vendor-specific SBAT entry to the SBAT section in each binary that supports SBAT metadata ( GRUB2, fwupd, fwupdate, systemd-boot, systemd-stub, shim + all child shim binaries )?
### Please provide exact SBAT entries for all SBAT binaries you are booting or planning to boot directly through shim.
### Where your code is only slightly modified from an upstream vendor's, please also preserve their SBAT entries to simplify revocation.
If you are using a downstream implementation of GRUB2 or systemd-boot (e.g.
from Fedora or Debian), please preserve the SBAT entry from those distributions
and only append your own. More information on how SBAT works can be found
[here](https://github.com/rhboot/shim/blob/main/SBAT.md).
*******************************************************************************

The shim sbat is:
sbat,1,SBAT Version,sbat,1,https://github.com/rhboot/shim/blob/main/SBAT.md
shim,4,UEFI shim,shim,1,https://github.com/rhboot/shim
shim.mariner,1,Microsoft,shim,15.8-1.cm2,https://github.com/microsoft/CBL-Mariner

The only applicable binary is for grub (we do not provide fwupd, fwupdate, systemd-boot, nor systemd-stub).

Our current grub sbat is:
sbat,1,SBAT Version,sbat,1,https://github.com/rhboot/shim/blob/main/SBAT.md
grub,2,Free Software Foundation,grub,2.06,https://www.gnu.org/software/grub/
grub.mariner,2,Microsoft,grub2,2.06-12.cm2,https://github.com/microsoft/CBL-Mariner

As noted earlier, we are adding patches to our grub and increasing its sbat level in this PR:
https://github.com/microsoft/CBL-Mariner/pull/7906

The grub sbat after that PR is merged will be:
sbat,1,SBAT Version,sbat,1,https://github.com/rhboot/shim/blob/main/SBAT.md
grub,4,Free Software Foundation,grub,2.06,https://www.gnu.org/software/grub/
grub.mariner,3,Microsoft,grub2,2.06-13.cm2,https://github.com/microsoft/CBL-Mariner

*******************************************************************************
### If shim is loading GRUB2 bootloader, which modules are built into your signed GRUB2 image?
*******************************************************************************

fat iso9660 part_gpt part_msdos normal boot linux configfile loopback chain efifwsetup efi_gop efi_uga ls search search_label search_fs_uuid search_fs_file gfxterm gfxterm_background gfxterm_menu test all_video loadenv exfat ext2 udf halt gfxmenu png tga lsefi help probe echo lvm cryptodisk luks gcry_rijndael gcry_sha512 tpm efinet tftp multiboot2 xfs

which can be seen at:
https://github.com/microsoft/CBL-Mariner/blob/2cdd0f179db1bb62752af7244ffe35ba0994e610/SPECS/grub2/grub2.spec#L291

*******************************************************************************
### If you are using systemd-boot on arm64 or riscv, is the fix for [unverified Devicetree Blob loading](https://github.com/systemd/systemd/security/advisories/GHSA-6m6p-rjcq-334c) included?
*******************************************************************************

Not using systemd-boot

*******************************************************************************
### What is the origin and full version number of your bootloader (GRUB2 or systemd-boot or other)?
*******************************************************************************

The source is from:
https://git.savannah.gnu.org/cgit/grub.git/snapshot/grub-2.06.tar.gz

And numerous patches are added, as seen in the spec file:
https://github.com/microsoft/CBL-Mariner/blob/2.0/SPECS/grub2/grub2.spec

The current full version number of our latest released grub2 rpm is 2.06-12.cm2, though we expect to release 2.06-13.cm2 along with (or before) this signed shim release, as previously mentioned.

*******************************************************************************
### If your SHIM launches any other components, please provide further details on what is launched.
*******************************************************************************

The shim only launches grub.

*******************************************************************************
### If your GRUB2 or systemd-boot launches any other binaries that are not the Linux kernel in SecureBoot mode, please provide further details on what is launched and how it enforces Secureboot lockdown.
*******************************************************************************

Grub launches only the Linux kernel in SecureBoot mode.

*******************************************************************************
### How do the launched components prevent execution of unauthenticated code?
*******************************************************************************

Grub has secure boot patches which will only load signed binaries. All modules used are built into the signed grub binary.

*******************************************************************************
### Does your SHIM load any loaders that support loading unsigned kernels (e.g. GRUB2)?
*******************************************************************************

No.

*******************************************************************************
### What kernel are you using? Which patches does it includes to enforce Secure Boot?
*******************************************************************************

Our kernel is based on the 5.15 release and regularly pulls patches from the upstream stable branch for 5.15.

Our current kernel tree is here:
https://github.com/microsoft/CBL-Mariner-Linux-Kernel/tree/rolling-lts/mariner-2/5.15.148.2

*******************************************************************************
### Add any additional information you think we may need to validate this shim.
*******************************************************************************

None
