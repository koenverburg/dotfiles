# install xcode

# echo "Installing homebrew ..."

which -s brew
if [[ $? != 0 ]] ; then
  yes | /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
  echo "Homebrew already installed ..."
fi

brew update

# brew install yarn, vscode, firefox, chrome, slack, insomnia, Iterm2, Alla
# Install zsh
brew install zsh
brew install zplug

brew tap caskroom/cask
brew tap caskroom/versions

# Browsers
brew cask install firefox
brew cask install google-chrome

# Other stuff
brew cask install spotify
brew cask install alacritty

# brew cask install alfred
# brew cask install bartender
# brew cask install karabiner-elements
# brew cask install flux

# Development stuff
brew install watchman
brew install tmux
brew install git
brew instal htop

# neovim
brew install python3
brew install neovim
pip3 install neovim
pip3 install pynvim

brew cask cleanup



# install the fonts
# symlink all the dotfiles

ln -s /Users/koenverburg/code/github/dotfiles/vscode/settings.json /Users/koenverburg/Library/Application\ Support/Code/User/settings.json
ln -s /Users/koenverburg/code/github/dotfiles/vscode/keybindings.json /Users/koenverburg/Library/Application\ Support/Code/User/keybindings.json

while read line; do code --install-extension $line; done < vscode/extensions.txt