# BigSurmountsrw
BigSur System snapshot mounter as rw

This app requires macOS Big Sur, it provides a simple interface to mount APFS System snapshot as writeable on a temporary mount point, then during that phase can make any system modification, when done simply click "Rebuild KC" button.

It is mainly for unsupported Big Sur Mac but should work also from a supported Mac, only requirements are:

- csrutil disable
- csrutil authenticated-root disable

from a recent T2 Mac is required to boot CMD+R and disable security as explained here: https://support.apple.com/en-us/HT208198
