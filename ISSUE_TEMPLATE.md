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

ddf770c9cac6a5cd693928bb047ea7c0d0dce51a3b7f4cde4dc08a919ab4538a  shimaa64.efi
ff49c422cab4d6252631e0e8593ab28d1e8e2f30b6c7b86593381f368bf1e314  shimx64.efi

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
