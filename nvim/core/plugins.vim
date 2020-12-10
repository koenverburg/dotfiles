let g:plugin_dir = expand('~/.config/nvim/plugins')

call plug#begin(g:plugin_dir)
Plug 'junegunn/vim-plug'
Plug 'sheerun/vim-polyglot'

" Colorscheme
Plug 'ajmwagar/vim-deus'
"Plug 'morhetz/gruvbox'
"Plug 'sainnhe/forest-night'
"Plug 'ayu-theme/ayu-vim'
Plug 'glepnir/zephyr-nvim'
Plug 'christianchiarulli/nvcode-color-schemes.vim'

" Finder
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
"Plug 'kyazdani42/nvim-web-devicons'

" LSP config
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'nvim-lua/diagnostic-nvim'
"Plug 'nvim-lua/lsp-status.nvim'  " lsp items in the statusbar
" Plug 'pierreglaser/folding-nvim', { 'for': ['lua', 'c', 'cpp', 'go'] } " LSP-powered folding

" Research
Plug 'nvim-treesitter/nvim-treesitter'
" Plug 'nvim-treesitter/completion-treesitter' " tree-sitter source for completion-nvim
" Plug 'steelsojka/completion-buffers' " buffer source for completion-nvim

"Misc
Plug '9mm/vim-closer'
Plug 'tpope/vim-surround' " Able to change [{()}]
Plug 'RRethy/vim-illuminate'

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
Plug 'easymotion/vim-easymotion'

" Convenience for commenting things in and out
Plug 'scrooloose/nerdcommenter'

" Auto close parens, braces, brackets, etc
"Plug 'jiangmiao/auto-pairs'

" Looks
Plug 'mhinz/vim-startify'

" Airline themes
"Plug 'glepnir/galaxyline.nvim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Git feedback in files
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" File tree
" Plug 'scrooloose/nerdtree'
Plug 'junegunn/limelight.vim'

" Find files
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

" Find in files
Plug 'mileszs/ack.vim'

" Faster Development
"Plug 'mizlan/termbufm'

" Linting error support for js,ts
" Plug 'desmap/ale-sensible'
" Plug 'w0rp/ale', { 'for': ['typescript', 'javascript'] }

call plug#end()
