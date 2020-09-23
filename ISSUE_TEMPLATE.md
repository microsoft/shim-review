Make sure you have provided the following information:

 - [ ] link to your code branch cloned from rhboot/shim-review in the form user/repo@tag
 - [ ] completed README.md file with the necessary information
 - [ ] shim.efi to be signed
 - [ ] public portion of your certificate(s) embedded in shim (the file passed to VENDOR_CERT_FILE)
 - [ ] binaries, for which hashes are added do vendor_db ( if you use vendor_db and have hashes whitelisted )
 - [ ] any extra patches to shim via your own git tree or as files
 - [ ] any extra patches to grub via your own git tree or as files
 - [ ] build logs


###### What organization or people are asking to have this signed:
Microsoft Corporation

###### What product or service is this for:
CBL-Mariner

###### What is the origin and full version number of your shim?
Shim-15 release tarball from https://github.com/rhboot/shim/releases/tag/15 plus
all 63 patches from most recent CentOS 7 shim package (shim-15-8.el7)

###### What's the justification that this really does need to be signed for the whole world to be able to boot it:
CBL-Mariner is an Linux distribution, built to run first party Azure cloud and edge workloads.

###### How do you manage and protect the keys used in your SHIM?
We use a hardware HSM

###### Do you use EV certificates as embedded certificates in the SHIM?
No

###### If you use new vendor_db functionality, are any hashes whitelisted, and if yes: for what binaries ?
No

###### Is kernel upstream commit 75b0cea7bf307f362057cc778efe89af4c615354 present in your kernel, if you boot chain includes a linux kernel ?
Yes, these commits are present in our linux kernel (baselined on 5.4.51 stable tree)
Source tree here: https://github.com/microsoft/WSL2-Linux-Kernel/tree/linux-msft-5.4.51

###### if SHIM is loading grub2 bootloader, is CVE CVE-2020-10713 fixed ?
Yes

##### Did you change your certificate strategy, so that affected by CVE CVE-2020-10713 grub2 bootloaders can not be verified ?
We did not sign any grub2 builds affected by the CVE. Our signed grub2 builds have the CVE fix.

###### What is the origin and full version number of your bootloader (GRUB or other)?
GRUB2 plus Secure Boot, TPM, and BootHole Patches

Baseline Grub 2.02 source tarball from ftp://ftp.gnu.org/gnu/grub/grub-2.02.tar.xz

See https://github.com/microsoft/CBL-Mariner/tree/1.0-stable/SPECS/grub2

###### If your SHIM launches any other components, please provide further details on what is launched
No other components launched by our shim.

###### How do the launched components prevent execution of unauthenticated code?
Grub verifies signatures of booted kernel

###### Does your SHIM load any loaders that support loading unsigned kernels (e.g. GRUB)?
No

###### What kernel are you using? Which patches does it includes to enforce Secure Boot?
The CBL-Mariner Linux kernel. It is based on 5.4.51 stable kernel.
Source tree here: https://github.com/microsoft/WSL2-Linux-Kernel/tree/linux-msft-5.4.51

###### What changes were made since your SHIM was last signed?
N/A

###### What is the hash of your final SHIM binary?
912772f957c4b65948f138815c8f525ef22039dc222b94842958e92fa3c86619  shimx64.efi