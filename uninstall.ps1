Remove-Item -Recurse -Force -Path "C:\Users\$($env:USERNAME)\dotfiles"
Write-Output "[!] Removed symlink to dotfiles repo"

# Remove-Item -Force -Path "C:\Users\$($env:USERNAME)\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"
# Write-Output "[!] Removed symlink to powershell profile"