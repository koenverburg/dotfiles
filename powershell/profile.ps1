Import-Module posh-git
Import-Module oh-my-posh
Import-Module Get-ChildItemColor
Import-Module AzureRM

Set-Alias vim nvim
Set-Alias gvim nvim-qt
Set-Alias touch New-Item

Set-Alias l Get-ChildItemColor -Option AllScope
Set-Alias ll Get-ChildItemColor -Option AllScope
Set-Alias ls Get-ChildItemColorFormatWide -Option AllScope

Set-Theme Paradox

Start-SshAgent
$env:ConEmuANSI = $True # hack for normal powershell

$ThemeSettings.Colors.GitForegroundColor = [ConsoleColor]::DarkGray
$ThemeSettings.Colors.SessionInfoBackgroundColor = [ConsoleColor]::DarkGray

function yt {
    yarn test -u --notify
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
function Set-Hosts {
    sudo notepad "$($env:SystemRoot)\system32\drivers\etc\hosts"
}

set-alias hosts Set-Hosts

function whats {
    Start-Process -FilePath "C:\Users\$($env:USERNAME)\AppData\Local\WhatsApp\WhatsApp.exe"
}
