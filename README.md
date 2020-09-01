# The DotFiles

This repo will have a collections of configs in this repo for: powershell, Neovim and vscode, scripts that automate some repetitive stuff

### Getting Started

Open up a Admin Powershell window and run the following

```powershell
Set-ExecutionPolicy -ExecutionPolicy AllSigned -Force

# Downloading Choco
iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# close and spin up a new terminal
choco install git -y
choco feature enable -n allowGlobalConfirmation
# Close and spin up a new terminal, this one doesn't have to be elevated
cd ~/code/github
git clone https://github.com/koenverburg/dotfiles.git

cd dotfiles
.\bootstrap.ps1
```


### Upgrading

```powershell
cup all -y
```
