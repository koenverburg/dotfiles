Import-Module posh-git
Import-Module oh-my-posh
Import-Module Get-ChildItemColor
Import-Module "$home\code\github\dotfiles\powershell\Helpers\aliases.ps1"
Import-Module "$home\code\github\dotfiles\overwrite\localProject.ps1"

Set-Alias vim nvim
Set-Alias gvim nvim-qt

Set-Alias l Get-ChildItemColor -Option AllScope
Set-Alias ll Get-ChildItemColor -Option AllScope
Set-Alias ls Get-ChildItemColorFormatWide -Option AllScope

Set-Theme Darkblood

Start-SshAgent
$env:ConEmuANSI = $True # hack for normal powershell

$ThemeSettings.Colors.GitForegroundColor = [ConsoleColor]::DarkGray
$ThemeSettings.Colors.SessionInfoBackgroundColor = [ConsoleColor]::DarkGray

$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())

if ($currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
  Import-Module "$home\code\github\dotfiles\powershell\lowerUACL.ps1"
}

if (-not $env:HOME) {
  $env:HOME = "$($env:HOMEDRIVE)$($env:HOMEPATH)"
}

function which($name) {
  Get-Command $name -ErrorAction SilentlyContinue | Select-Object Definition
}

function touch($file) {
  "" | Out-File $file -Encoding ASCII
}

function elevateProcess {
  $file, [string]$arguments = $args;
  $psi = new-object System.Diagnostics.ProcessStartInfo $file;
  $psi.Arguments = $arguments;
  $psi.Verb = "runas";
  $psi.WorkingDirectory = get-location;
  [System.Diagnostics.Process]::Start($psi) >> $null
}

set-alias sudo elevateProcess

function whats {
  Start-Process "$env:LOCALAPPDATA\WhatsApp\WhatsApp.exe"
}

function whatsk {
  elevateProcess taskkill.exe "/IM WhatsApp.exe /F"
  Clear-Host
}

function Set-Hosts {
  sudo notepad "$($env:SystemRoot)\system32\drivers\etc\hosts"
}

set-alias hosts Set-Hosts

function editLocal {
  code $env:HOME\dotfiles\overwrite\localProject.ps1
}

# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}
