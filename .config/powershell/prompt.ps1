function prompt {

    # Assign Windows Title Text
    $host.ui.RawUI.WindowTitle = $pwd

    #Configure current user, current folder and date outputs
    $currentPath = Split-Path -Path $pwd -Leaf
    $CmdPromptUser = [Security.Principal.WindowsIdentity]::GetCurrent();

    # check if the user is levated
    $IsAdmin = (New-Object Security.Principal.WindowsPrincipal ([Security.Principal.WindowsIdentity]::GetCurrent())).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)

    # Painting
    #Write-Host ""
    Write-host ($(if ($IsAdmin) { '! ' } else { '' })) -BackgroundColor DarkRed -ForegroundColor White -NoNewline

    Write-Host "$currentPath " -NoNewline

    return "~ "
}
