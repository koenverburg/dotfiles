# $terminalFolder = Get-ChildItem "C:\Users\$($env:USERNAME)\AppData\Local\Packages" -filter "Microsoft.WindowsTerminal_*" -Directory | ForEach-Object { $_.fullname }
# if ($terminalFolder) {
#   $cleanTerminalPath = $terminalFolder.Substring("C:\Users\$env:USERNAME\AppData\Local\".Length)
#   if (Test-Path "$env:LOCALAPPDATA\$cleanTerminalPath\LocalState\settings.json") {
#     Remove-Item "$env:LOCALAPPDATA\$cleanTerminalPath\LocalState\settings.json" -Force
#   }
#   UnstowFile "$env:LOCALAPPDATA\$cleanTerminalPath\LocalState\settings.json" (Get-Item ".\Terminal\settings.json").FullName
# }

# Powershell Profile(s)
UnstowFile $env:USERPROFILE\Documents\PowerShell\Microsoft.PowerShell_profile.ps1
UnstowFile $env:USERPROFILE\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1 # powershell 5, no need for it

## Neovim

# symlinking the config
UnstowFile $env:LOCALAPPDATA\nvim\init.vim

# All the other files
Unstow "$env:LOCALAPPDATA\nvim\lua\kv"
Unstow "$env:LOCALAPPDATA\nvim\lua\finder"
Unstow "$env:LOCALAPPDATA\nvim\lua"
Unstow "$env:LOCALAPPDATA\nvim\core"
Unstow "$env:LOCALAPPDATA\nvim\config"
Unstow "$env:LOCALAPPDATA\nvim\plugins"
Unstow "$env:LOCALAPPDATA\nvim\settings"

# Alacritty
UnstowFile $env:APPDATA\alacritty\alacritty.yml

# vs Code
UnstowFile $env:APPDATA\Code\User\settings.json
UnstowFile $env:APPDATA\Code\User\keybindings.json
