let g:plugin_dir = expand('~/.config/nvim/plugins')

call plug#begin(g:plugin_dir)

" Colorscheme
Plug 'morhetz/gruvbox'
Plug 'sainnhe/forest-night'

" LSP config
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'nvim-lua/diagnostic-nvim'
" Plug 'pierreglaser/folding-nvim', { 'for': ['lua', 'c', 'cpp', 'go'] } " LSP-powered folding
" Plug 'nvim-lua/lsp-status.nvim'  " lsp items in the statusbar

" Research
" Plug 'nvim-treesitter/nvim-treesitter'
" Plug 'nvim-treesitter/completion-treesitter' " tree-sitter source for completion-nvim
" Plug 'steelsojka/completion-buffers' " buffer source for completion-nvim

Plug '9mm/vim-closer'
Plug 'tpope/vim-surround' " Able to change '"[{()}]

" Language Support
" Plug 'elzr/vim-json'
" Plug 'othree/yajs.vim'
" Plug 'pangloss/vim-javascript'
" Plug 'leafgarland/typescript-vim'
" Plug 'herringtondarkholme/yats.vim'
" Plug 'godlygeek/tabular'
" Plug 'plasticboy/vim-markdown'

" View indenting
" Plug 'Yggdroot/indentLine'

" WordJumping like resharper
Plug 'bkad/CamelCaseMotion'

" Convenience for commenting things in and out
" Plug 'scrooloose/nerdcommenter'

" Auto close parens, braces, brackets, etc
" Plug 'jiangmiao/auto-pairs'

" Airline themes
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'

" Git feedback in files
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" File tree
" Plug 'scrooloose/nerdtree'

" Find files
" Plug 'junegunn/fzf'
" Plug 'junegunn/fzf.vim'

" Find in files
" Plug 'mileszs/ack.vim'

" Linting error support for js,ts and elixir
" Plug 'desmap/ale-sensible'
" Plug 'w0rp/ale', { 'for': ['typescript', 'javascript'] }

" Autocomplete
" Plug 'neoclide/coc.nvim', { 'branch': 'release' }

call plug#end()