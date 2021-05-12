# BigSurmountsrw
BigSur System snapshot read write mounter

This app requires macOS Big Sur, it provides a simple interface to mount APFS System snapshot as writeable on a temporary mount point, then during that phase can make any system modification directly from Finder (if close Finder to find the "System rw mount point" simply from Disk Utility or easier unzip the attached alias to desktop), keep running the app until you made the modifications, when done simply click "Rebuild KC" button, wait a couple of minutes to get a log (to check eventual errors) and notification.

It is mainly for unsupported Big Sur Mac but should work also from a supported Mac, only requirements are:

- csrutil disable
- csrutil authenticated-root disable

from a recent T2 Mac is required to boot CMD+R and disable security as explained here: https://support.apple.com/en-us/HT208198
