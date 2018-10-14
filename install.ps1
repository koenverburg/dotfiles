New-Item -ItemType Junction -Path "C:\Users\$($env:USERNAME)\dotfiles" -Value $($pwd) >> $null
Write-Output "[i] Create a Junction for ~/Dotfiles"

New-Item -ItemType SymbolicLink -Path "C:\Users\$($env:USERNAME)\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1" -Value ".\powershell\profile.ps1" -Force >> $null
Write-Output "[i] Symlinked powershell profile"

New-Item -ItemType SymbolicLink -Path "C:\Users\$($env:USERNAME)\Documents\WindowsPowerShell\poshThemes\koenverburg.psm1" -Value ".\cmder\koenverburg.psm1" -Force >> $null
Write-Output "[i] Create a a symlink for the cmder theme"

.\ConEmu-Color-Themes\Install-ConEmuTheme.ps1 -ConfigPath "C:\tools\cmder\vendor\conemu-maximus5\ConEmu.xml" -Operation Add -ThemePathOrName ".\ConEmu-Color-Themes\themes\ayu Mirage.xml"
Write-Output "[i] Install the ayu theme"