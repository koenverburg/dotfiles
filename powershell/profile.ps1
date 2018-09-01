Import-Module posh-git
Import-Module oh-my-posh
Import-Module Get-ChildItemColor

Set-Theme Agnoster

Set-Alias vim nvim
Set-Alias gvim nvim-qt
Set-Alias time Measure-Command
Set-Alias l Get-ChildItemColor -Option AllScope
Set-Alias ll Get-ChildItemColor -Option AllScope
Set-Alias ls Get-ChildItemColorFormatWide -Option AllScope

$ThemeSettings.Colors.SessionInfoBackgroundColor = [ConsoleColor]::DarkMagenta
$ThemeSettings.Colors.GitForegroundColor = [ConsoleColor]::DarkMagenta

# Basic commands
function which($name) { Get-Command $name -ErrorAction SilentlyContinue | Select-Object Definition }
function touch($file) { "" | Out-File $file -Encoding ASCII }
function elevateProcess {
    $file, [string] $arguments = $args;
    $psi = New-Object System.Diagnostics.ProcessStartInfo $file;
    $psi.Arguments = $arguments;
    $psi.Verb = "runas";
    $psi.WorkingDirectory = Get-Location;
    [System.Diagnostics.Process]::Start($psi) >> $null
}
Set-Alias sudo elevateProcess

function SetHosts {
    sudo notepad "$($env:SystemRoot)\system32\drivers\etc\hosts"
}
Set-Alias hosts SetHosts

function ohboi {
    git add --all
    git commit -am "added stuff"
    git push
}

# jump to folders

