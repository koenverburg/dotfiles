Set-Alias vim nvim
Set-Alias gvim nvim-qt

Set-Alias l Get-ChildItemColor -Option AllScope
Set-Alias ll Get-ChildItemColor -Option AllScope
Set-Alias ls Get-ChildItemColorFormatWide -Option AllScope

New-Alias open ii

# GO
function grm { go run main.go }

function cpanel {
  $wtProfile = "Powershell"
  wt -p $wtProfile -d $args `; split-pane -V -p $wtProfile -d $args `; split-pane -H -p $wtProfile -d $args
}

function which($name) {
  Get-Command $name -ErrorAction SilentlyContinue | Select-Object Definition
}

function touch($file) {
  "" | Out-File $file -Encoding ASCII
}

function elevateProcess {
  $file, [string]$arguments = $args;
  $psi = new-object System.Diagnostics.ProcessStartInfo $file;
  $psi.Arguments = $arguments;
  $psi.Verb = "runas";
  $psi.WorkingDirectory = get-location;
  [System.Diagnostics.Process]::Start($psi) >> $null
}

set-alias sudo elevateProcess

function whats {
  Start-Process "$env:LOCALAPPDATA\WhatsApp\WhatsApp.exe"
}

function whatsk {
  elevateProcess taskkill.exe "/IM WhatsApp.exe /F"
  Clear-Host
}

function Set-Hosts {
  sudo notepad "$($env:SystemRoot)\system32\drivers\etc\hosts"
}

set-alias hosts Set-Hosts

function editLocal {
  code $env:HOME\dotfiles\overwrite\localProject.ps1
}