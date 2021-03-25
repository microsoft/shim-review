Make sure you have provided the following information:

 - [ ] link to your code branch cloned from rhboot/shim-review in the form user/repo@tag
 - [ ] completed README.md file with the necessary information
 - [ ] shim.efi to be signed
 - [ ] public portion of your certificate(s) embedded in shim (the file passed to VENDOR_CERT_FILE)
 - [ ] binaries, for which hashes are added do vendor_db ( if you use vendor_db and have hashes allow-listed )
 - [ ] any extra patches to shim via your own git tree or as files
 - [ ] any extra patches to grub via your own git tree or as files
 - [ ] build logs


###### What organization or people are asking to have this signed:
Microsoft Corporation

###### What product or service is this for:
CBL-Mariner

###### Please create your shim binaries starting with the 15.4 shim release tar file:
###### https://github.com/rhboot/shim/releases/download/15.4/shim-15.4.tar.bz2
###### This matches https://github.com/rhboot/shim/releases/tag/15.4 and contains
###### the appropriate gnu-efi source.
###### Please confirm this as the origin your shim.
Confirmed. We are building from the shim-15.4 tar file.

###### What's the justification that this really does need to be signed for the whole world to be able to boot it:
CBL-Mariner is an Linux distribution, built to run first party Azure cloud and edge workloads.

###### How do you manage and protect the keys used in your SHIM?
We use a hardware HSM

###### Do you use EV certificates as embedded certificates in the SHIM?
No

###### If you use new vendor_db functionality, are any hashes allow-listed, and if yes: for what binaries ?
No

###### Is kernel upstream commit 75b0cea7bf307f362057cc778efe89af4c615354 present in your kernel, if you boot chain includes a Linux kernel ?
Yes, these commits are present in our linux kernel. We are baselined on 5.10 LTS stable tree.
Source tree here: https://github.com/microsoft/CBL-Mariner-Linux-Kernel/tree/rolling-lts/mariner/5.10.21.1
- https://github.com/microsoft/CBL-Mariner-Linux-Kernel/commit/824d0b6225f3fa2992704478a8df520537cfcb56
- https://github.com/microsoft/CBL-Mariner-Linux-Kernel/commit/1957a85b0032a81e6482ca4aab883643b8dae06e

###### if SHIM is loading GRUB2 bootloader, are CVEs CVE-2020-14372,
###### CVE-2020-25632, CVE-2020-25647, CVE-2020-27749, CVE-2020-27779,
###### CVE-2021-20225, CVE-2021-20233, CVE-2020-10713, CVE-2020-14308,
###### CVE-2020-14309, CVE-2020-14310, CVE-2020-14311, CVE-2020-15705,
###### ( July 2020 grub2 CVE list + March 2021 grub2 CVE list )
###### and if you are shipping the shim_lock module CVE-2021-3418
###### fixed ?
Yes. Our GRUB2 is baselined on 2.06-rc1 which has these fixes.

###### "Please specifically confirm that you add a vendor specific SBAT entry for SBAT header in each binary that supports SBAT metadata
###### ( grub2, fwupd, fwupdate, shim + all child shim binaries )" to shim review doc ?
###### Please provide exact SBAT entries for all SBAT binaries you are booting or planning to boot directly through shim
SHIM SBAT entry example:
```
sbat,1,SBAT Version,sbat,1,https://github.com/rhboot/shim/blob/main/SBAT.md
shim,1,UEFI shim,shim,1,https://github.com/rhboot/shim
shim.mariner,1,Microsoft,shim,15.4-1.cm1,https://github.com/microsoft/CBL-Mariner
```

GRUB2 SBAT entry example:
```
sbat,1,SBAT Version,sbat,1,https://github.com/rhboot/shim/blob/main/SBAT.md
grub,1,Free Software Foundation,grub,2.06~rc1,https://www.gnu.org/software/grub/
grub.mariner,1,Microsoft,grub2,2.06~rc1-1.cm1,https://github.com/microsoft/CBL-Mariner
```

##### Were your old SHIM hashes provided to Microsoft ?
N/A. This is our first SHIM review request.

##### Did you change your certificate strategy, so that affected by CVE-2020-14372, CVE-2020-25632, CVE-2020-25647, CVE-2020-27749,
##### CVE-2020-27779, CVE-2021-20225, CVE-2021-20233, CVE-2020-10713,
##### CVE-2020-14308, CVE-2020-14309, CVE-2020-14310, CVE-2020-14311, CVE-2020-15705 ( July 2020 grub2 CVE list + March 2021 grub2 CVE list )
##### grub2 bootloaders can not be verified ?
We have a new signing key for grub2. We did not sign any grub2 builds affected by these CVEs with this new key. Our signed grub2 builds have the CVE fixes.

##### What exact implementation of Secureboot in grub2 ( if this is your bootloader ) you have ?
##### * Upstream grub2 shim_lock verifier or * Downstream RHEL/Fedora/Debian/Canonical like implementation ?
GRUB2 2.06-rc1 + Secure Boot patches from Fedora 34.

###### What is the origin and full version number of your bootloader (GRUB or other)?
Baseline is Grub 2.06-rc1 + Secure Boot patches from Fedora 34 + a few extra patches from Fedora 34

Our latest Grub2 spec and patches can be found here: https://github.com/microsoft/CBL-Mariner/tree/1.0-dev/SPECS/grub2

The current grub2 source RPM is also provided in this repository: [grub2-2.06~rc1-1.cm1.src.rpm](grub2-2.06~rc1-1.cm1.src.rpm)

###### If your SHIM launches any other components, please provide further details on what is launched
No other components launched by our shim.

###### If your GRUB2 launches any other binaries that are not Linux kernel in SecureBoot mode,
###### please provide further details on what is launched and how it enforces Secureboot lockdown
N/A - we only launch the Linux kernel

###### If you are re-using a previously used (CA) certificate, you
###### will need to add the hashes of the previous GRUB2 binaries
###### exposed to the CVEs to vendor_dbx in shim in order to prevent
###### GRUB2 from being able to chainload those older GRUB2 binaries. If
###### you are changing to a new (CA) certificate, this does not
###### apply. Please describe your strategy.
N/A. We changed to a new certificate.

###### How do the launched components prevent execution of unauthenticated code?
Grub2 has secure boot patches which will only load signed binaries.
All modules used are built into GRUB2 binary.

###### Does your SHIM load any loaders that support loading unsigned kernels (e.g. GRUB)?
No

###### What kernel are you using? Which patches does it includes to enforce Secure Boot?
We use the CBL-Mariner Linux Kernel, which is based on the 5.10 LTS kernel.
Current source tree here: https://github.com/microsoft/CBL-Mariner-Linux-Kernel/tree/rolling-lts/mariner/5.10.21.1

###### What changes were made since your SHIM was last signed?
N/A

###### What is the SHA256 hash of your final SHIM binary?
4930a1506341f7a37f4f22dd284d90e64bb4fb99ca8ee634b10ee52951e3604f  shimx64.efi
