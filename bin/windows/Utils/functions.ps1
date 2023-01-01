function Write-Error([string]$message) {
  [Console]::ForegroundColor = 'red'
  [Console]::Error.WriteLine($message)
  [Console]::ResetColor()
}

function Write-Warn([string]$message) {
  [Console]::ForegroundColor = 'yellow'
  [Console]::Error.WriteLine($message)
  [Console]::ResetColor()
}

function StowFile([String]$link, [String]$target) {
  $file = Get-Item $link -ErrorAction SilentlyContinue

  if ($file) {
    if ($file.LinkType -ne "SymbolicLink") {
      Write-Error "[!] $($file.FullName) already exists and is not a symbolic link"
      return
    }
    elseif ($file.Target -ne $target) {
      Write-Error "[!] $($file.FullName) already exists and points to '$($file.Target)', it should point to '$target'"
      return
    }
    else {
      Write-Output "[!] $($file.FullName) already linked"
      return
    }
  }
  else {
    $folder = Split-Path $link
    if (-not (Test-Path $folder)) {
      Write-Output "[i] Creating folder $folder"
      [void](New-Item -Type Directory -Path $folder)
    }
  }

  Write-Output "[i] Creating link $link to $target"
  [void]((New-Item -Path $link -ItemType SymbolicLink -Value $target -ErrorAction Continue).Target)
}

function Stow([String]$target, [String]$package) {
  if (-not $target) {
    Write-Error "[!] Could not define the target link folder of $package"
  }

  Get-ChildItem $package | ForEach-Object {
    if (-not $_.PSIsContainer) {
      StowFile (Join-Path -Path $target -ChildPath $_.Name) $_.FullName
    }
  }
}

function UnstowFile([String]$file) {
  if (Test-Path "$file") {
    Remove-Item "$file" -Force
    Write-Output "[i] Removed $file"
  }
  else {
    Write-Output "[i] File $file is already removed, consider removing this 'UnstowFile' from your bootstrapper"
  }
}

function Unstow([String]$package) {
  if (-not $package) {
    Write-Error "[!] Could not find folder of $package"
  }

  if (Test-Path (Resolve-Path $package).Path) {
    Get-ChildItem $package | ForEach-Object {
      if (-not $_.PSIsContainer) {
        Write-Output "[i] Removed $_.Name"
        UnstowFile (Join-Path -Path $package -ChildPath $_.Name)
      }
    }

    if (Test-Path (Resolve-Path $package).Path) {
      Write-Output "[i] Removed $package folder"
      Remove-Item (Resolve-Path $package).Path -Force
    }
  } else {
    Write-Error "[!] Folder already removed $package"
  }
}

function Install([String]$package, [bool]$beta = $false, [bool]$skipCheckSum = $false) {
  if (-not ((choco list $package --exact --local-only --limitoutput) -like "$package*")) {
    Write-Output "[i] Installing package $package"
    if ($beta) {
      choco install $package -y --pre
    }
    elseif ($skipCheckSum) {
      choco install $package -y --ignore-checksums
    }
    elseif ($beta -And $skipCheckSum) {
      choco install $package -y --pre --ignore-checksums
    }
    else {
      choco install $package -y
    }
  }
  else {
    Write-Output "[i] Package $package already installed"
  }
}

function Uninstall([String]$package) {
  if (((choco list $package --exact --local-only --limitoutput) -like "$package*")) {
    Write-Output "[i] package $package is installed, removing it.."
    choco uninstall $package -y
  }
  else {
    Write-Output "[i] Package $package is already removed, consider removing this uninstall from your bootstrapper"
  }
}
