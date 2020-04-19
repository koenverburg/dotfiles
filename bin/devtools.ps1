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
  start-process pwsh.exe -argument '-nologo -noprofile -command Install-Module posh-git -Force'
  start-process pwsh.exe -argument '-nologo -noprofile -command Install-Module oh-my-posh -Force'
  start-process pwsh.exe -argument '-nologo -noprofile -command Install-Module pure-pwsh -Force'
  start-process pwsh.exe -argument '-nologo -noprofile -command Install-Module Get-ChildItemColor -Force -AllowClobber'
  start-process pwsh.exe -argument '-nologo -noprofile -command Install-Module -Name PSReadLine -AllowPrerelease -Force -SkipPublisherCheck'
}

# Powershell Profile(s)
StowFile $env:HOME\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1 (Get-Item ".\powershell\profile.ps1").FullName
StowFile $env:HOME\Documents\PowerShell\Microsoft.PowerShell_profile.ps1 (Get-Item ".\powershell\profile.ps1").FullName

# Install microsoft-windows-terminal
$terminalFolder = Get-ChildItem "C:\Users\$($env:USERNAME)\AppData\Local\Packages" -filter "Microsoft.WindowsTerminal_*" -Directory | ForEach-Object { $_.fullname }
if ($terminalFolder) {
  $cleanTerminalPath = $terminalFolder.Substring("C:\Users\$env:USERNAME\AppData\Local\".Length)
  if (Test-Path "$env:LOCALAPPDATA\$cleanTerminalPath\LocalState\profiles.json") {
    Remove-Item "$env:LOCALAPPDATA\$cleanTerminalPath\LocalState\profiles.json" -Force
  }
  StowFile "$env:LOCALAPPDATA\$cleanTerminalPath\LocalState\profiles.json" (Get-Item ".\Terminal\profiles.json").FullName
}

# vs Code
StowFile $env:APPDATA\Code\User\settings.json (Get-Item ".\vscode\settings.json").FullName
StowFile $env:APPDATA\Code\User\keybindings.json (Get-Item ".\vscode\keybindings.json").FullName

# Cmder config
if (Test-Path "C:\tools\cmder\vendor\conemu-maximus5\ConEmu.xml") {
  Rmove-Item "C:\tools\cmder\vendor\conemu-maximus5\ConEmu.xml" -Force
  StowFile "C:\tools\cmder\vendor\conemu-maximus5\ConEmu.xml" (Get-Item ".\cmder\settings.xml").FullName
}
.\ConEmu-Color-Themes\Install-ConEmuTheme.ps1 -ConfigPath "C:\tools\cmder\vendor\conemu-maximus5\ConEmu.xml" -Operation Add -ThemePathOrName ".\ConEmu-Color-Themes\themes\ayu Mirage.xml"

# Neovim
if (-not (Test-Path "C:\Users\$($env:USERNAME)\AppData\Local\nvim\autoload")) {
  mkdir -Path "C:\Users\$($env:USERNAME)\AppData\Local\nvim\autoload" >> $null

  $uri = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  (New-Object Net.WebClient).DownloadFile(
    $uri,
    $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath(
      "C:\Users\$($env:USERNAME)\AppData\Local\nvim\autoload\plug.vim"
    )
  )
}


# new config
StowFile $env:LOCALAPPDATA\nvim\init.vim (Get-Item ".\nvim\init.vim").FullName

StowFile $env:LOCALAPPDATA\nvim\scripts\autocmd.vim (Get-Item ".\neovim\scripts\autocmd.vim").FullName
StowFile $env:LOCALAPPDATA\nvim\scripts\general.vim (Get-Item ".\neovim\scripts\general.vim").FullName
StowFile $env:LOCALAPPDATA\nvim\scripts\plugins.vim (Get-Item ".\neovim\scripts\plugins.vim").FullName
StowFile $env:LOCALAPPDATA\nvim\scripts\search.vim (Get-Item ".\neovim\scripts\search.vim").FullName
StowFile $env:LOCALAPPDATA\nvim\scripts\shortcuts.vim (Get-Item ".\neovim\scripts\shortcuts.vim").FullName
StowFile $env:LOCALAPPDATA\nvim\scripts\autocomplete.vim (Get-Item ".\neovim\scripts\autocomplete.vim").FullName

# StowFile "$env:LOCALAPPDATA\nvim\coc-settings.json" (Get-Item ".\neovim\coc-settings.json").FullName