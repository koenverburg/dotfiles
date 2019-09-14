#Requires -RunAsAdministrator
. ".\bin\Utils\functions.ps1"

New-Item -ItemType Junction -Path "C:\Users\$($env:USERNAME)\dotfiles" -Value $($pwd)
Write-Output "[i] Create a symlink for ~/Dotfiles"

Set-StrictMode -version Latest
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# Sanity Check
if (-not [environment]::Is64BitOperatingSystem) {
  Write-Error "Only 64 bit Windows is supported"
  exit
}

if (-not $env:HOME) {
  $env:HOME = "$($env:HOMEDRIVE)$($env:HOMEPATH)"
}

. ".\bin\devtools.ps1"
# . ".\bin\programs.ps1"
. ".\bin\Settings\wallpaper.ps1"