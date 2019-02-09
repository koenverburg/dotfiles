New-Item -ItemType Junction -Path "C:\Users\$($env:USERNAME)\dotfiles" -Value $($pwd) >> $null
Write-Output "[i] Create a Junction for ~/Dotfiles"

Import-Module ".\cmder\install.ps1"
Import-Module ".\powershell\install.ps1"

Import-Module ".\vscode\install.ps1"
Import-Module ".\neovim\install.ps1"