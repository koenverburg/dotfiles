Import-Module Get-ChildItemColor
Import-Module PSReadline

# Aliases
Import-Module "$home\code\github\dotfiles\.config\powershell\Aliases\folderjumping.ps1"
Import-Module "$home\code\github\dotfiles\.config\powershell\Aliases\general.ps1"
Import-Module "$home\code\github\dotfiles\.config\powershell\Aliases\shutup.ps1"
Import-Module "$home\code\github\dotfiles\.config\powershell\Aliases\poweruser.ps1"
Import-Module "$home\code\github\dotfiles\.config\powershell\Aliases\git.ps1"
Import-Module "$home\code\github\dotfiles\.config\powershell\Aliases\terraform.ps1"
Import-Module "$home\code\github\dotfiles\overwrite\localProject.ps1"
Import-Module "$home\code\github\dotfiles\.config\powershell\prompt.ps1"

prompt;


Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
# Autocompletion for arrow keys
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward


$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())

if ($currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
  Import-Module "$home\code\github\dotfiles\.config\powershell\lowerUACL.ps1"
  Clear-Host
} else {
  Clear-Host
}

if (-not $env:HOME) {
  $env:HOME = "$($env:HOMEDRIVE)$($env:HOMEPATH)"
}

# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}
