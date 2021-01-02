$latestRelease = 'https://github.com/neovim/neovim/releases/download/nightly/nvim-win64.zip'
$nvimLatestPath = 'C:\tools\neovim\nvim-win64'
$nvimPathCurrent = 'C:\tools\neovim\Neovim'
$nvimPathCurrentTemp = 'C:\tools\neovim\_Neovim'
$nvimPathZip = 'C:\tools\neovim\nvim-win64.zip'

nvim --version

Invoke-WebRequest $latestRelease -OutFile $nvimPathZip
Expand-Archive $nvimPathZip -DestinationPath $nvimLatestPath
# clean up
Remove-Item $nvimPathZip

# underscore the current release
Rename-Item -Path $nvimPathCurrent -NewName $nvimPathCurrentTemp
Move-Item -Path "$nvimLatestPath\Neovim" -Destination $nvimPathCurrent
Remove-Item $nvimLatestPath
Remove-Item $nvimPathCurrentTemp

RefreshEnv

nvim --version
