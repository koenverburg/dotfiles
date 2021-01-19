git clone https://github.com/neovim/neovim.git $HOME/neovim
cd $HOME/neovim
sudo make distclean
sudo make CMAKE_BUILD_TYPE=Release
sudo make install