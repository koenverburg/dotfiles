# install xcode

echo "Let's get this Arrow Flying.."

which -s brew
if [[ $? != 0 ]] ; then
  yes | /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
  echo "Homebrew already installed ..."
fi

brew update

# Install zsh
brew install zsh
brew install zplug

brew tap caskroom/cask
brew tap caskroom/versions

# Browsers
brew cask install firefox
brew cask install google-chrome

Other stuff
brew cask install spotify
brew cask install alacritty

# Maybe, maybe not
# brew cask install alfred
# brew cask install bartender
# brew cask install karabiner-elements
# brew cask install flux

# Development stuff
brew install go
brew install watchman
brew install tmux
brew install git
brew install node
brew install yarn
brew install rbenv
rbenv init
rbenv install 2.7.0
rbenv shell 2.7.0
npm install -g artillery serve
# Search
brew install the_silver_searcher
brew install rg
brew install ack # find in files
brew install fzf # fuzzy finder

# neovim
brew install python3  # brew install is not overriding the build in one...
brew install neovim
pip3 install neovim
pip3 install pynvim
gem install neovim
sudo rm -R ~/.local # removing stuff so that nvim can startup in one go

# Install other useful binaries.
brew install htop
# brew install youtube-dl

# Fonts
https://github.com/caskroom/homebrew-fonts
brew tap homebrew/cask-fonts
brew cask install homebrew/cask-fonts/font-hack
brew cask install homebrew/cask-fonts/font-hack-nerd-font
brew cask install homebrew/cask-fonts/font-source-code-pro

brew cask cleanup

gem update --system
gem install tmuxinator
gem install foreman

# neovim setups (partly)
# Neovim
if [ -e "$HOME/.config/nvim/autoload/plug.vim" ]; then
  echo "vim plug exists for neovim, skipping ..."
else
  curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# symlink all the dotfiles

# Terminal setup
ln -s ~/code/github/dotfiles/tmuxinator/ ~/.config/tmuxinator/
ln -s ~/code/github/dotfiles/nvim/ ~/.config/nvim/
ln -s ~/code/github/dotfiles/macos/.zshrc ~/.zshrc

# VS code
ln -s ˜/code/github/dotfiles/vscode/settings.json ˜/Library/Application\ Support/Code/User/settings.json
ln -s ˜/code/github/dotfiles/vscode/keybindings.json ˜/Library/Application\ Support/Code/User/keybindings.json
while read line; do code --install-extension $line; done < vscode/extensions.txt