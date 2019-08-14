$koenverburgThemepwsh5 = "C:\Users\$($env:USERNAME)\Documents\WindowsPowerShell\poshThemes\koenverburg.psm1"
$koenverburgThemepwsh6 = "C:\Users\$($env:USERNAME)\Documents\PowerShell\poshThemes\koenverburg.psm1"

$kvPure_pwsh5 = "C:\Users\$($env:USERNAME)\Documents\WindowsPowerShell\poshThemes\pure_koenverburg.psm1"
$kvPure_pwsh6 = "C:\Users\$($env:USERNAME)\Documents\PowerShell\poshThemes\pure_koenverburg.psm1"

if (-Not (Test-Path -Path $koenverburgThemepwsh5)) {
  New-Item -ItemType SymbolicLink -Path $koenverburgThemepwsh5 -Value ".\cmder\koenverburg.psm1" -Force >> $null
}
Else { Write-Information "It's is there" }

if (-Not (Test-Path -Path $koenverburgThemepwsh6)) {
  New-Item -ItemType SymbolicLink -Path $koenverburgThemepwsh6 -Value ".\cmder\koenverburg.psm1" -Force >> $null
}
Else { Write-Information "It's is there" }

if (-Not (Test-Path -Path $kvPure_pwsh5)) {
  New-Item -ItemType SymbolicLink -Path $kvPure_pwsh5 -Value ".\cmder\pure_koenverburg.psm1" -Force >> $null
}
Else { Write-Information "It's is there" }

if (-Not (Test-Path -Path $kvPure_pwsh6)) {
  New-Item -ItemType SymbolicLink -Path $kvPure_pwsh6 -Value ".\cmder\pure_koenverburg.psm1" -Force >> $null
}
Else { Write-Information "It's is there" }

Write-Output "[i] Create a a symlink for the cmder theme"

$cmderConfig = "C:\tools\cmder\vendor\conemu-maximus5\ConEmu.xml"

if (-Not (Test-Path -Path $cmderConfig)) {
  .\ConEmu-Color-Themes\Install-ConEmuTheme.ps1 -ConfigPath -Operation Add -ThemePathOrName ".\ConEmu-Color-Themes\themes\ayu Mirage.xml"
}
Else { Write-Information "It's is there" }

Write-Output "[i] Install the ayu theme"
