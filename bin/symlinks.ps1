# PowerShell Modules
# this will run under powershell 5, this should be placed in another file.
# if (!(Get-Module posh-git)) {
#   Install-Module posh-git -Force
# }

# if (!(Get-Module oh-my-posh)) {
#   Install-Module oh-my-posh -Force
# }

# if (!(Get-Module Get-ChildItemColor)) {
#   Install-Module -Name Get-ChildItemColor -Force
# }

# # this will be installed under pwsh 6 core
# if (Get-Command 'pwsh.exe') {
#   start-process pwsh.exe -argument '-nologo -noprofile -command Install-Module windows-screenfetch -Force'
#   start-process pwsh.exe -argument '-nologo -noprofile -command Install-Module posh-git -Force'
#   start-process pwsh.exe -argument '-nologo -noprofile -command Install-Module oh-my-posh -Force'
#   start-process pwsh.exe -argument '-nologo -noprofile -command Install-Module Get-ChildItemColor -Force -AllowClobber'
#   start-process pwsh.exe -argument '-nologo -noprofile -command Install-Module -Name PSReadLine -AllowPrerelease -Force -SkipPublisherCheck'
# }

if(-not (Test-Path ".\overwrite")) {
  mkdir .\overwrite
  touch .\overwrite\localProject.ps1
} else {
  Write-Output "Overwrite folder in place"
}

# Install microsoft-windows-terminal, Always delete and place a new one
# TODO place this in another file.
$terminalFolder = Get-ChildItem "C:\Users\$($env:USERNAME)\AppData\Local\Packages" -filter "Microsoft.WindowsTerminal_*" -Directory | ForEach-Object { $_.fullname }
if ($terminalFolder) {
  $cleanTerminalPath = $terminalFolder.Substring("C:\Users\$env:USERNAME\AppData\Local\".Length)
  if (Test-Path "$env:LOCALAPPDATA\$cleanTerminalPath\LocalState\settings.json") {
    Remove-Item "$env:LOCALAPPDATA\$cleanTerminalPath\LocalState\settings.json" -Force
  }
  StowFile "$env:LOCALAPPDATA\$cleanTerminalPath\LocalState\settings.json" (Get-Item ".\.config\Terminal\settings.json").FullName
}

# Powershell Profile(s)
StowFile $env:USERPROFILE\Documents\PowerShell\Microsoft.PowerShell_profile.ps1 (Get-Item ".\.config\powershell\profile.ps1").FullName
StowFile $env:USERPROFILE\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1 (Get-Item ".\.config\powershell\profile.ps1").FullName # powershell 5, no need for it

## Neovim

# symlinking the config
StowFile $env:LOCALAPPDATA\nvim\init.vim (Get-Item ".\.config\nvim\init.vim").FullName
# StowFile $env:LOCALAPPDATA\nvim\ginit.vim (Get-Item ".\.config\nvim\ginit.vim").FullName

# All the other files
Stow "$env:LOCALAPPDATA\nvim\lua" ".\.config\nvim\lua"
Stow "$env:LOCALAPPDATA\nvim\lua\kv" ".\.config\nvim\lua\kv"
Stow "$env:LOCALAPPDATA\nvim\lua\finder" ".\.config\nvim\lua\finder"
Stow "$env:LOCALAPPDATA\nvim\core" ".\.config\nvim\core"
Stow "$env:LOCALAPPDATA\nvim\config" ".\.config\nvim\config"
Stow "$env:LOCALAPPDATA\nvim\plugins" ".\.config\nvim\plugins"
Stow "$env:LOCALAPPDATA\nvim\settings" ".\.config\nvim\settings"

# Alacritty
StowFile $env:APPDATA\alacritty\alacritty.yml (Get-Item ".\.config\alacritty\alacritty.yml").FullName

# vs Code
StowFile $env:APPDATA\Code\User\settings.json (Get-Item ".\.config\vscode\settings.json").FullName
StowFile $env:APPDATA\Code\User\keybindings.json (Get-Item ".\.config\vscode\keybindings.json").FullName
