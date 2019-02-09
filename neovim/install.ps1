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