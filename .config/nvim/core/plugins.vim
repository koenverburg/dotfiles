let g:plugin_dir = expand('~/.config/nvim/plugins')

call plug#begin(g:plugin_dir)
Plug 'junegunn/vim-plug'
Plug 'sheerun/vim-polyglot'

" Colorscheme
Plug 'trusktr/seti.vim'
Plug 'ajmwagar/vim-deus'
Plug 'glepnir/zephyr-nvim'
Plug 'christianchiarulli/nvcode-color-schemes.vim'

" Finders
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'mileszs/ack.vim'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'gfanto/fzf-lsp.nvim'

" LSP config
Plug 'neovim/nvim-lsp'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'nvim-lua/diagnostic-nvim'
"Plug 'nvim-lua/lsp-status.nvim'  " lsp items in the statusbar

" Research
Plug 'nvim-treesitter/nvim-treesitter'
" Plug 'nvim-treesitter/completion-treesitter' " tree-sitter source for completion-nvim
" Plug 'steelsojka/completion-buffers' " buffer source for completion-nvim

"Misc
Plug 'tpope/vim-surround' " Able to change [{()}]
Plug 'RRethy/vim-illuminate'

" Lanaguages
"
Plug 'elzr/vim-json'
Plug 'stephpy/vim-yaml'
Plug 'PProvost/vim-ps1'
" Plug 'plasticboy/vim-markdown'
" Plug 'godlygeek/tabular'

" View indenting
" Plug 'Yggdroot/indentLine'

" WordJumping like resharper and faster movement
"Plug 'bkad/CamelCaseMotion'
Plug 'easymotion/vim-easymotion'

" Convenience for commenting things in and out
Plug 'scrooloose/nerdcommenter'

" Auto close parens, braces, brackets, etc
Plug 'jiangmiao/auto-pairs'

" Looks
Plug 'mhinz/vim-startify'
Plug 'ryanoasis/vim-devicons'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"Plug 'glepnir/galaxyline.nvim'

" Git feedback in files
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" Focus mode
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

"Plug 'tjdevries/cyclist.vim'

" DevOps Stuff
Plug 'hashivim/vim-terraform'
Plug 'hashicorp/terraform-ls'
" Linting error support for js,ts
" Plug 'desmap/ale-sensible'
" Plug 'w0rp/ale', { 'for': ['typescript', 'javascript'] }

call plug#end()
