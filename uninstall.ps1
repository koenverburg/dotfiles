Remove-Item -Recurse -Force -Path "C:\Users\$($env:USERNAME)\dotfiles"
Write-Output "[!] Removed symlink to dotfiles repo"

Remove-Item -Force -Path "C:\Users\$($env:USERNAME)\Documents\WindowsPowerShell\poshThemes\koenverburg.psm1"
Remove-Item -Force -Path "C:\Users\$($env:USERNAME)\Documents\WindowsPowerShell\poshThemes"
Write-Output "[!] Removed symlink for the cmder theme"

Remove-Item -Force -Path "C:\Users\$($env:USERNAME)\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"
Remove-Item -Force -Path "C:\Users\$($env:USERNAME)\Documents\WindowsPowerShell"
Write-Output "[!] Removed symlink to powershell profile"
