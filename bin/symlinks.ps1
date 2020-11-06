# PowerShell Modules
# this will run under powershell 5
if (!(Get-Module posh-git)) {
  Install-Module posh-git -Force
}

if (!(Get-Module oh-my-posh)) {
  Install-Module oh-my-posh -Force
}

if (!(Get-Module Get-ChildItemColor)) {
  Install-Module -Name Get-ChildItemColor -Force
}

# this will be installed under pwsh 6 core
if (Get-Command 'pwsh.exe') {
  start-process pwsh.exe -argument '-nologo -noprofile -command Install-Module windows-screenfetch -Force'
  start-process pwsh.exe -argument '-nologo -noprofile -command Install-Module posh-git -Force'
  start-process pwsh.exe -argument '-nologo -noprofile -command Install-Module oh-my-posh -Force'
  start-process pwsh.exe -argument '-nologo -noprofile -command Install-Module Get-ChildItemColor -Force -AllowClobber'
  start-process pwsh.exe -argument '-nologo -noprofile -command Install-Module -Name PSReadLine -AllowPrerelease -Force -SkipPublisherCheck'
}

# Powershell Profile(s)
StowFile $env:HOME\Documents\PowerShell\Microsoft.PowerShell_profile.ps1 (Get-Item ".\powershell\profile.ps1").FullName
# StowFile $env:HOME\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1 (Get-Item ".\powershell\profile.ps1").FullName # powershell 5, no need for it

# Install microsoft-windows-terminal, Always delete and place a new one
$terminalFolder = Get-ChildItem "C:\Users\$($env:USERNAME)\AppData\Local\Packages" -filter "Microsoft.WindowsTerminal_*" -Directory | ForEach-Object { $_.fullname }
if ($terminalFolder) {
  $cleanTerminalPath = $terminalFolder.Substring("C:\Users\$env:USERNAME\AppData\Local\".Length)
  if (Test-Path "$env:LOCALAPPDATA\$cleanTerminalPath\LocalState\settings.json") {
    Remove-Item "$env:LOCALAPPDATA\$cleanTerminalPath\LocalState\settings.json" -Force
  }
  StowFile "$env:LOCALAPPDATA\$cleanTerminalPath\LocalState\settings.json" (Get-Item ".\Terminal\settings.json").FullName
}

# vs Code
StowFile $env:APPDATA\Code\User\settings.json (Get-Item ".\vscode\settings.json").FullName
StowFile $env:APPDATA\Code\User\keybindings.json (Get-Item ".\vscode\keybindings.json").FullName

# Neovim
# installing Plug the plugin manager for Vim
if (-not (Test-Path "C:\Users\$($env:USERNAME)\AppData\Local\nvim\autoload")) {
  mkdir -Path "C:\Users\$($env:USERNAME)\AppData\Local\nvim\autoload" >> $null

  $uri = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  (New-Object Net.WebClient).DownloadFile(
    $uri,
    $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath(
      "C:\Users\$($env:USERNAME)\AppData\Local\nvim\autoload\plug.vim"
    )
  )
} else {
  Write-Output "[!] Neovim plug is already installed"
}

# symlinking the config
StowFile $env:LOCALAPPDATA\nvim\init.vim (Get-Item ".\nvim\init.vim").FullName
StowFile $env:LOCALAPPDATA\nvim\ginit.vim (Get-Item ".\nvim\ginit.vim").FullName

# language server
StowFile "$env:LOCALAPPDATA\nvim\coc-settings.json" (Get-Item ".\nvim\coc-settings.json").FullName

# All the other files
Stow ".\nvim\core" "$env:LOCALAPPDATA\nvim\core"
Stow ".\nvim\config" "$env:LOCALAPPDATA\nvim\config"
Stow ".\nvim\plugins" "$env:LOCALAPPDATA\nvim\plugins"
Stow ".\nvim\settings" "$env:LOCALAPPDATA\nvim\settings"

# Alacritty
StowFile $env:APPDATA\alacritty\alacritty.yml (Get-Item ".\alacritty\alacritty.yml").FullName