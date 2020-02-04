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
  if (Test-Path "$env:LOCALAPPDATA\$cleanTerminalPath\RoamingState\profiles.json") {
    Remove-Item "$env:LOCALAPPDATA\$cleanTerminalPath\RoamingState\profiles.json" -Force
  }
  StowFile "$env:LOCALAPPDATA\$cleanTerminalPath\RoamingState\profiles.json" (Get-Item ".\Terminal\profiles.json").FullName
}

# vs Code
StowFile $env:APPDATA\Code\User\settings.json (Get-Item ".\vscode\settings.json").FullName
StowFile $env:APPDATA\Code\User\keybindings.json (Get-Item ".\vscode\keybindings.json").FullName

# vs code Insiders Dont know if i'm keeping vscode insiders since my neovim is working again
# Install visualstudiocode-insiders $true
# StowFile "$env:APPDATA\Code - Insiders\User\settings.json" (Get-Item ".\vscode\settings.json").FullName
# StowFile "$env:APPDATA\Code - Insiders\User\keybindings.json" (Get-Item ".\vscode\keybindings.json").FullName

# Cmder config
if (Test-Path "C:\tools\cmder\vendor\conemu-maximus5\ConEmu.xml") {
  Remove-Item "C:\tools\cmder\vendor\conemu-maximus5\ConEmu.xml" -Force
  StowFile "C:\tools\cmder\vendor\conemu-maximus5\ConEmu.xml" (Get-Item ".\cmder\settings.xml").FullName
}
# .\ConEmu-Color-Themes\Install-ConEmuTheme.ps1 -ConfigPath "C:\tools\cmder\vendor\conemu-maximus5\ConEmu.xml" -Operation Add -ThemePathOrName ".\ConEmu-Color-Themes\themes\ayu Mirage.xml"

# oh my posh theme
StowFile "$env:HOME\Documents\WindowsPowerShell\poshThemes\koenverburg.psm1" (Get-Item ".\cmder\koenverburg.psm1").FullName
StowFile "$env:HOME\Documents\Powershell\poshThemes\koenverburg.psm1" (Get-Item ".\cmder\koenverburg.psm1").FullName
StowFile "$env:HOME\Documents\WindowsPowerShell\poshThemes\pure_koenverburg.psm1" (Get-Item ".\cmder\pure_koenverburg.psm1").FullName
StowFile "$env:HOME\Documents\Powershell\poshThemes\pure_koenverburg.psm1" (Get-Item ".\cmder\pure_koenverburg.psm1").FullName

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

StowFile $env:LOCALAPPDATA\nvim\ginit.vim (Get-Item ".\neovim\ginit.vim").FullName
StowFile $env:LOCALAPPDATA\nvim\init.vim (Get-Item ".\neovim\init.vim").FullName
StowFile "$env:LOCALAPPDATA\nvim\coc-settings.json" (Get-Item ".\neovim\coc-settings.json").FullName