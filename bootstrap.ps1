#Requires -RunAsAdministrator
. ".\bin\Utils\functions.ps1"

Set-StrictMode -version Latest
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# Sanity Check
if (-not [environment]::Is64BitOperatingSystem) {
  Write-Error "[!] Only 64 bit Windows is supported"
  exit
}

if (-not $env:HOME) {
  $env:HOME = "$($env:HOMEDRIVE)$($env:HOMEPATH)"
}
elseif ($env:HOME -eq "H:\") {
  $env:HOME = "C:$($env:HOMEPATH)"
}

. ".\bin\programs.ps1"
. ".\bin\symlinks.ps1"
. ".\vscode\install.ps1"

RefreshEnv.cmd

if(-not (Test-Path ".\overwrite")) {
  mkdir .\overwrite
  touch .\overwrite\localProject.ps1
} else {
  Write-Output "Overwrite folder in place"
}
