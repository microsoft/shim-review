Confirm the following are included in your repo, checking each box:

 - [x] completed README.md file with the necessary information
 - [x] shim.efi to be signed
 - [x] public portion of your certificate(s) embedded in shim (the file passed to VENDOR_CERT_FILE)
 - [x] binaries, for which hashes are added to vendor_db ( if you use vendor_db and have hashes allow-listed )
 - [x] any extra patches to shim via your own git tree or as files
 - [x] any extra patches to grub via your own git tree or as files
 - [x] build logs
 - [x] a Dockerfile to reproduce the build of the provided shim EFI binaries

*******************************************************************************
### What is the link to your tag in a repo cloned from rhboot/shim-review?
*******************************************************************************
`https://github.com/user/shim-review/tree/myorg-shim-arch-YYYYMMDD`

*******************************************************************************
### What is the SHA256 hash of your final SHIM binary?
*******************************************************************************

7905c30de3109eb4ff8a5d198f5077bceb35b0fc3559b03924cf78a96e511bd0  shimaa64.efi
83c927eada08e0811adbaab47323841808d79e51d11aa8072c552bfbf80af801  shimx64.efi

*******************************************************************************
### What is the link to your previous shim review request (if any, otherwise N/A)?
*******************************************************************************

https://github.com/rhboot/shim-review/issues/387

*******************************************************************************
### If no security contacts have changed since verification, what is the link to your request, where they've been verified (if any, otherwise N/A)?
*******************************************************************************

Dan Streetman:
https://github.com/rhboot/shim-review/issues/387#issuecomment-2042990828

Chris Co:
https://github.com/rhboot/shim-review/issues/387#issuecomment-2072937510
