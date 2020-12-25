" My Vimrc
" Author: Koen Verburg <creativekoen@gmail.com>
" Source: https://github.com/koenverburg/dotfiles

" Core
source $HOME/code/github/dotfiles/.config/nvim/core/plugins.vim
source $HOME/code/github/dotfiles/.config/nvim/core/gui.vim
" source $HOME/code/github/dotfiles/.config/nvim/core/runtime.vim

" Settings
source $HOME/code/github/dotfiles/.config/nvim/settings/general.vim

" Config
source $HOME/code/github/dotfiles/.config/nvim/config/keybindings.vim

" Plugins
source $HOME/code/github/dotfiles/.config/nvim/plugins/plugin-settings.vim
source $HOME/code/github/dotfiles/.config/nvim/plugins/lspconfig.vim
"source $HOME/code/github/dotfiles/.config/nvim/plugins/treesitter.vim
source $HOME/code/github/dotfiles/.config/nvim/plugins/telescope.vim
source $HOME/code/github/dotfiles/.config/nvim/plugins/fuzzyfind.vim
source $HOME/code/github/dotfiles/.config/nvim/plugins/startup.vim
" source $HOME/code/github/dotfiles/.config/nvim/plugins/termbuffer.vim

lua require('init')
