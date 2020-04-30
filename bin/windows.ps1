# used from https://github.com/jivkok/dotfiles/blob/master/windows/BoxStarter.psm1
Import-Module ".\Utils\BoxStarter.psm1"

Set-TaskbarSmall
Restart-Explorer
Set-ExplorerOptions -showHidenFilesFoldersDrives $true -showProtectedOSFiles $true -showFileExtensions $true
# Disable-ShutdownTracker
# Disable-InternetExplorerESC
