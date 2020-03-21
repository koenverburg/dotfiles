let g:plugin_dir = expand('~/.neovim/plugin')

set nocompatible
filetype off

call plug#begin(g:plugin_dir)

" ================= looks and GUI stuff ================== "
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'                          " airline status bar
Plug 'vim-airline/vim-airline-themes'                   " airline themes

" ================= Functionalities ================= "

" auto completion, lang servers and stuff
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'desmap/ale-sensible' | Plug 'w0rp/ale', { 'for': ['typescript', 'javascript'] }
Plug 'bkad/CamelCaseMotion'

" search
" Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'ctrlpvim/ctrlp.vim'

" languages
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'HerringtonDarkholme/yats.vim' " TS Syntax
Plug 'elzr/vim-json'
Plug 'mxw/vim-jsx'
Plug 'othree/yajs.vim'
Plug 'pangloss/vim-javascript'
Plug 'elixir-lang/vim-elixir'

" other
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-commentary'                             " better commenting
Plug 'tpope/vim-sensible'                               " sensible defaults
Plug 'tpope/vim-fugitive'                               " git support
Plug 'tpope/vim-surround'                               " surround stuff with stuff
Plug 'psliwka/vim-smoothie'                             " some very smooth ass scrolling
Plug 'farmergreg/vim-lastplace'                         " open files at the last edited place

" Zen
Plug 'junegunn/limelight.vim'

" interface
Plug 'editorconfig/editorconfig-vim'
Plug 'airblade/vim-gitgutter'
Plug 'Yggdroot/indentLine'
Plug 'scrooloose/nerdtree'
Plug 'kassio/neoterm'
Plug 'janko/vim-test'

call plug#end()

filetype plugin indent on
syntax enable
