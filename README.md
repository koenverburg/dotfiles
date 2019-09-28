# The DotFiles

So we will have a collections of configs in this repo for: powershell, neovim and vscode
Things you might find here are my neovim config, ps functions for easy jumping to project folders and keybinds/plugins that I use in vs code

### Getting Started

open up a Admin Powershell window and run the following

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Force
iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
# close and spin up a new terminal
choco install git -y
# close and spin up a new terminal
cd ~/your/code/dir
# or
cd C:\code\github # I work with different services so mine word be C:\code\github
git clone --recurse-submodules https://github.com/koenverburg/dotfiles.git
cd dotfiles
.\bootstrap.ps1
```
