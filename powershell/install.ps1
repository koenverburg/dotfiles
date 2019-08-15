$profileV5 = "C:\Users\$($env:USERNAME)\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"
$profileV6 = "C:\Users\$($env:USERNAME)\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"

if (-Not (Test-Path -Path $profileV5)) {
  New-Item -ItemType SymbolicLink -Path $profileV5 -Value ".\powershell\profile.ps1" -Force >> $null
}
Else { Write-Information "[i] Powershell Profile for v5 has already been set" }

if (-Not (Test-Path -Path $profileV6)) {
  New-Item -ItemType SymbolicLink -Path $profileV6 -Value ".\powershell\profile.ps1" -Force >> $null
  Write-Information "[i] set powershell v6 profile"
}
Else { Write-Information "[i] Powershell Profile for v6 has already been set" }





Write-Output "[i] Symlinked powershell profile"