#Requires -RunAsAdministrator
Set-StrictMode -version Latest

# update powershell/pwsh
if (!(Get-Module posh-git)) {
  Update-Module posh-git -Force
}

if (!(Get-Module oh-my-posh)) {
  Update-Module oh-my-posh -Force
}

if (!(Get-Module Get-ChildItemColor)) {
  Update-Module -Name Get-ChildItemColor -Force
}

if (($PSVersionTable).PSEdition -eq 'Core') {
  Update-Module -Name PSReadLine -AllowPrerelease -Force
}

$DotFilesPath = Split-Path $MyInvocation.MyCommand.Path
Push-Location $DotFilesPath
try {
  # Dotfiles
  git pull --ff-only

  # Chocolatey
  cup all -y

  # Vim Plugins
  # gvim -c "PlugUpdate" -c "qa!"

  # Windows Update
  # if (Get-Command -Module PSWindowsUpdate) {
  #   Get-WUInstall –MicrosoftUpdate –AcceptAll # –AutoReboot
  # }
}
finally {
  Pop-Location
}

