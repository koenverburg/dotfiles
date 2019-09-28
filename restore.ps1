if (-not $env:HOME) {
  $env:HOME = "$($env:HOMEDRIVE)$($env:HOMEPATH)"
}

Remove-Item $env:HOME\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1 -Force
Remove-Item $env:HOME\Documents\PowerShell\Microsoft.PowerShell_profile.ps1 -Force

Remove-Item $env:APPDATA\Code\User\settings.json -Force
Remove-Item $env:APPDATA\Code\User\keybindings.json -Force

Remove-Item "$env:APPDATA\Code - Insiders\User\settings.json" -Force
Remove-Item "$env:APPDATA\Code - Insiders\User\keybindings.json" -Force

$terminalFolder = Get-ChildItem "C:\Users\$($env:USERNAME)\AppData\Local\Packages" -filter "Microsoft.WindowsTerminal_*" -Directory | ForEach-Object { $_.fullname }
if ($terminalFolder) {
  $cleanTerminalPath = $terminalFolder.Substring("C:\Users\$env:USERNAME\AppData\Local\".Length)
  Remove-Item "$env:LOCALAPPDATA\$cleanTerminalPath\RoamingState\profiles.json" -Force
}

Remove-Item "$env:HOME\Documents\WindowsPowerShell\poshThemes\koenverburg.psm1" -Force
Remove-Item "$env:HOME\Documents\Powershell\poshThemes\koenverburg.psm1" -Force

Remove-Item "$env:HOME\Documents\WindowsPowerShell\poshThemes\pure_koenverburg.psm1" -Force
Remove-Item "$env:HOME\Documents\Powershell\poshThemes\pure_koenverburg.psm1" -Force

Remove-Item $env:LOCALAPPDATA\nvim\ginit.vim -Force
Remove-Item $env:LOCALAPPDATA\nvim\init.vim -Force