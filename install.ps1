New-Item -Path "C:\Users\$($env:USERNAME)\dotfiles" -ItemType SymbolicLink -Value $pwd >> $null
Write-Output "symlinked powershell profile"

New-Item -Path "C:\Users\$($env:USERNAME)\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1" -ItemType SymbolicLink -Value ".\powershell\profile.ps1" >> $null
Write-Output "symlinked powershell profile"