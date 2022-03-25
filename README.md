# The DotFiles

This repo will have a collections of configs of powershell, fish, Neovim and tmux, probably more. This is consantly changing and can be broken. [Pilfer](https://www.collinsdictionary.com/dictionary/english/pilfer) at your own risk.

### Getting Started

#### Windows
Open up a Admin Powershell window and run the following

```powershell
Set-ExecutionPolicy -ExecutionPolicy Bypass -Force

# Downloading Choco
iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# close and spin up a new terminal
choco install git python -y
choco feature enable -n allowGlobalConfirmation

cd ~/code/github
git clone https://github.com/koenverburg/dotfiles.git
cd dotfiles
./install.ps1
```

### Upgrading

```powershell
cup all -y
```
