param($step)
switch ($step) {
  "features" {
    dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
    dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
  }
  "set-version" {
    wsl --set-default-version 2
  }
  Default {
    Write-Output "Select: features | set-version"
  }
}
