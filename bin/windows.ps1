#Requires -RunAsAdministrator
# Import-Module ".\bin\Settings\taskbar.ps1"
Import-Module ".\bin\Settings\wallpaper.ps1"

$StartUp = "$Env:USERPROFILE\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"

function New-Shortcut($ShortcutPath, $TargetPath, $Arguments, $IconLocation) {
  $WshShell = New-Object -comObject WScript.Shell
  $Shortcut = $WshShell.CreateShortcut($ShortcutPath)
  $Shortcut.TargetPath = $TargetPath
  $Shortcut.Arguments = $Arguments
  $Shortcut.IconLocation = $IconLocation
  $Shortcut.Save()
}

function PinToTaskBar($filePath) {
  if (!(Test-Path $filePath)) {
    Write-Warning "$filePath does not exist."
    return
  }

  $folder = Split-Path $filePath -Parent
  $fileName = Split-Path $filePath -Leaf

  $shellApp = New-Object -c Shell.Application
  $folderItem = $shellApp.Namespace($folder).ParseName($fileName)

  # debugging
  # foreach ($verb in $folderItem.Verbs()) {
  #   if ($verb.Name.Replace("&", "") -match "Pin to Start") {
  #     Write-Output $verb.Name
  #     $verb | Get-Member
  #     # $item | Get-Member
  #   }
  # }
  $folderItem.InvokeVerb('&Pin to Start')
}

# Install microsoft-windows-terminal
# local path is for the config file (profiles.json)
# $terminalFolder = Get-ChildItem "C:\Program Files\WindowsApps\" -filter "Microsoft.WindowsTerminal_*" -Directory | ForEach-Object { $_.fullname }
# Write-Output $terminalFolder[0]

# if ($terminalFolder[0]) {
#   New-Shortcut "$Home\Desktop\Windows-Terminal.lnk" "$terminalFolder[0]\WindowsTerminal.exe" "" "$terminalFolder[0]\Images\Square44x44Logo.scale-150.png,0"
#   # PinToTaskBar "$Home\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Insomnia\Insomnia.lnk" $terminalFolder[0]
#   # PinToTaskBar ""
# }

# PinToTaskBar "C:\Users\Koen Verburg\Desktop\"
# PinToTaskBar "C:\Users\$env:USERNAME"
# Write-Output "Desktop shortcut (and taskbar pin): $Home\Desktop\Shell.lnk => $Env:ChocolateyInstall\bin\Console.exe"

# used from https://github.com/jivkok/dotfiles/blob/master/windows/BoxStarter.psm1
Import-Module ".\Windows\BoxStarter.psm1"

Set-TaskbarSmall
Restart-Explorer
Set-ExplorerOptions -showHidenFilesFoldersDrives $true -showProtectedOSFiles $true -showFileExtensions $true
# Disable-ShutdownTracker
# Disable-InternetExplorerESC

# New-Item -ItemType SymbolicLink -Path "$StartUp" -Name "$name" -Value "$exePath"
# Windows Terminal
# New-Item -ItemType SymbolicLink -Path "$StartUp" -Name "WindowsTerminal.lnk" -Value "C:\Program Files\WindowsApps\Microsoft.WindowsTerminal_0.3.2171.0_x64__8wekyb3d8bbwe\WindowsTerminal.exe"
# New-Item -ItemType SymbolicLink -Path "$StartUp" -Name "FireFox.lnk" -Value "C:\Program Files\Firefox Developer Edition\firefox.exe"
# New-Item -ItemType SymbolicLink -Path "$StartUp" -Name "FireFox.lnk" -Value "C:\Program Files\Firefox Developer Edition\firefox.exe"
