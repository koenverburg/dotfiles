" My Vimrc
" Author: Koen Verburg <creativekoen@gmail.com>
" Source: https://github.com/koenverburg/dotfiles

" Core
source $HOME/code/github/dotfiles/nvim/core/plugins.vim
source $HOME/code/github/dotfiles/nvim/core/runtime.vim
source $HOME/code/github/dotfiles/nvim/core/gui.vim

" Settings
source $HOME/code/github/dotfiles/nvim/settings/general.vim

" Config
source $HOME/code/github/dotfiles/nvim/config/keybindings.vim

" Plugins
source $HOME/code/github/dotfiles/nvim/plugins/plugin-settings.vim
source $HOME/code/github/dotfiles/nvim/plugins/lspconfig.vim
source $HOME/code/github/dotfiles/nvim/plugins/treesitter.vim
source $HOME/code/github/dotfiles/nvim/plugins/telescope.vim
source $HOME/code/github/dotfiles/nvim/plugins/fuzzyfind.vim
source $HOME/code/github/dotfiles/nvim/plugins/startup.vim
source $HOME/code/github/dotfiles/nvim/plugins/termbuffer.vim

lua require('init')
