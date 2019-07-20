New-Item -ItemType SymbolicLink -Path "C:\Users\$($env:USERNAME)\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1" -Value ".\powershell\profile.ps1" -Force >> $null
New-Item -ItemType SymbolicLink -Path "C:\Users\$($env:USERNAME)\Documents\PowerShell\Microsoft.PowerShell_profile.ps1" -Value ".\powershell\profile.ps1" -Force >> $null
Write-Output "[i] Symlinked powershell profile"