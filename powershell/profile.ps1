Import-Module posh-git
Import-Module oh-my-posh
Import-Module Get-ChildItemColor
Import-Module PSReadline

# Aliases
Import-Module "$home\code\github\dotfiles\powershell\Aliases\folderjumping.ps1"
Import-Module "$home\code\github\dotfiles\powershell\Aliases\general.ps1"
Import-Module "$home\code\github\dotfiles\powershell\Aliases\shutup.ps1"
Import-Module "$home\code\github\dotfiles\powershell\Aliases\poweruser.ps1"
Import-Module "$home\code\github\dotfiles\powershell\Aliases\git.ps1"
Import-Module "$home\code\github\dotfiles\powershell\Aliases\terraform.ps1"
Import-Module "$home\code\github\dotfiles\overwrite\localProject.ps1"

Set-Theme Pure

Start-SshAgent
$env:ConEmuANSI = $True # hack for normal powershell

$ThemeSettings.Colors.GitForegroundColor = [ConsoleColor]::DarkGray
$ThemeSettings.Colors.SessionInfoBackgroundColor = [ConsoleColor]::DarkGray

$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())

if ($currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
  Import-Module "$home\code\github\dotfiles\powershell\lowerUACL.ps1"
  Clear-Host
  Write-Output "Running as Administrator"
} else {
  Clear-Host
}

if (-not $env:HOME) {
  $env:HOME = "$($env:HOMEDRIVE)$($env:HOMEPATH)"
}

Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
# Autocompletion for arrow keys
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward

# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}
