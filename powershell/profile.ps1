Import-Module posh-git
Import-Module oh-my-posh
Import-Module Get-ChildItemColor
Import-Module "C:\Users\$($env:USERNAME)\dotfiles\powershell\Helpers\aliases.ps1"

Set-Alias vim nvim
Set-Alias gvim nvim-qt

Set-Alias l Get-ChildItemColor -Option AllScope
Set-Alias ll Get-ChildItemColor -Option AllScope
Set-Alias ls Get-ChildItemColorFormatWide -Option AllScope

Set-Theme pure

Start-SshAgent
$env:ConEmuANSI = $True # hack for normal powershell

$ThemeSettings.Colors.GitForegroundColor = [ConsoleColor]::DarkGray
$ThemeSettings.Colors.SessionInfoBackgroundColor = [ConsoleColor]::DarkGray

$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())

if ($currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
  Import-Module "C:\Users\$($env:USERNAME)\dotfiles\powershell\lowerUACL.ps1"
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

function quiet {
  elevateProcess taskkill.exe "/IM teams.exe /F"
}

function Set-Hosts {
  sudo notepad "$($env:SystemRoot)\system32\drivers\etc\hosts"
}

set-alias hosts Set-Hosts

function editLocal {
  code "C:\Users\$($env:USERNAME)\dotfiles\overwrite\localProject.ps1"
}

Import-Module "C:\Users\$($env:USERNAME)\dotfiles\overwrite\localProject.ps1"

# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}
