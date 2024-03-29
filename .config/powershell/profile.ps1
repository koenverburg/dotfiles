Import-Module Get-ChildItemColor
Import-Module PSReadline
# Import-Module oh-my-posh
Import-Module syntax-highlighting

# Aliases
Import-Module "$home\code\github\dotfiles\.config\powershell\Aliases\folderjumping.ps1"
Import-Module "$home\code\github\dotfiles\.config\powershell\Aliases\general.ps1"
Import-Module "$home\code\github\dotfiles\.config\powershell\Aliases\shutup.ps1"
Import-Module "$home\code\github\dotfiles\.config\powershell\Aliases\poweruser.ps1"
Import-Module "$home\code\github\dotfiles\.config\powershell\Aliases\git.ps1"
Import-Module "$home\code\github\dotfiles\.config\powershell\Aliases\terraform.ps1"
Import-Module "$home\code\github\dotfiles\overwrite\localProject.ps1"
Import-Module "$home\code\github\dotfiles\.config\powershell\prompt.ps1"

Set-PSReadLineOption -PredictionSource History
Set-PSReadlineKeyHandler -Key "Tab" -Function MenuComplete
Set-PSReadlineKeyHandler -Key "UpArrow" -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key "DownArrow" -Function HistorySearchForward
Set-PSReadLineOption -Colors @{ InlinePrediction = '#898c5b'}
Set-PSReadlineOption -HistorySearchCursorMovesToEnd
Set-PSReadLineKeyHandler -Key "RightArrow" -ScriptBlock {
  param($key, $arg)

  $line = $null
  $cursor = $null
  [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)

  if ($cursor -lt $line.Length) {
    [Microsoft.PowerShell.PSConsoleReadLine]::ForwardChar($key, $arg)
  } else {
    [Microsoft.PowerShell.PSConsoleReadLine]::AcceptNextSuggestionWord($key, $arg)
  }
}

Set-PSReadLineKeyHandler -Key End -ScriptBlock {
  param($key, $arg)

  $line = $null
  $cursor = $null
  [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)

  if ($cursor -lt $line.Length) {
    [Microsoft.PowerShell.PSConsoleReadLine]::EndOfLine($key, $arg)
  } else {
    [Microsoft.PowerShell.PSConsoleReadLine]::AcceptSuggestion($key, $arg)
  }
}

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

$ENV:STARSHIP_CONFIG = "$HOME\.config\starship.toml"
Invoke-Expression (&starship init powershell)
