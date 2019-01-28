New-Item -ItemType Junction -Path "C:\Users\$($env:USERNAME)\dotfiles" -Value $($pwd) >> $null
Write-Output "[i] Create a Junction for ~/Dotfiles"

New-Item -ItemType SymbolicLink -Path "C:\Users\$($env:USERNAME)\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1" -Value ".\powershell\profile.ps1" -Force >> $null
Write-Output "[i] Symlinked powershell profile"

New-Item -ItemType SymbolicLink -Path "C:\Users\$($env:USERNAME)\Documents\WindowsPowerShell\poshThemes\koenverburg.psm1" -Value ".\cmder\koenverburg.psm1" -Force >> $null
Write-Output "[i] Create a a symlink for the cmder theme"

.\ConEmu-Color-Themes\Install-ConEmuTheme.ps1 -ConfigPath "C:\tools\cmder\vendor\conemu-maximus5\ConEmu.xml" -Operation Add -ThemePathOrName ".\ConEmu-Color-Themes\themes\ayu Mirage.xml"
Write-Output "[i] Install the ayu theme"

mkdir -Path "C:\Users\$($env:USERNAME)\AppData\Local\nvim\autoload" >> $null

$uri = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
(New-Object Net.WebClient).DownloadFile(
    $uri,
    $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath(
        "C:\Users\$($env:USERNAME)\AppData\Local\nvim\autoload\plug.vim"
    )
)

New-Item -ItemType SymbolicLink -Path "C:\Users\$($env:USERNAME)\AppData\Local\nvim\ginit.vim" -Value ".\neovim\ginit.vim" -Force >> $null
Write-Output "[i] Symlinked neovim ginit.vim"

New-Item -ItemType SymbolicLink -Path "C:\Users\$($env:USERNAME)\AppData\Local\nvim\init.vim" -Value ".\neovim\init.vim" -Force >> $null
Write-Output "[i] Symlinked neovim init.vim"