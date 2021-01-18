local repo = 'https://github.com/savq/paq-nvim.git'
local install_path = vim.fn.stdpath('data') .. '/site/pack/paq/opt/paq-nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  print 'Downloading Plugin Manager..'
  vim.api.nvim_command(string.format('!git clone %s "%s"', repo, install_path))
end

vim.api.nvim_command [[ packadd paq-nvim ]]

local paq = require'paq-nvim'.paq
paq 'savq/paq-nvim'

-- Colorscheme
paq 'trusktr/seti.vim'
paq 'ajmwagar/vim-deus'
paq 'glepnir/zephyr-nvim'
paq 'christianchiarulli/nvcode-color-schemes.vim'

-- Finders
paq 'nvim-lua/popup.nvim'
paq 'nvim-lua/plenary.nvim'
paq 'nvim-telescope/telescope.nvim'
paq 'mileszs/ack.vim'
paq 'junegunn/fzf'
paq 'junegunn/fzf.vim'
-- paq 'gfanto/fzf-lsp.nvim'

-- LSP config
paq 'neovim/nvim-lsp'
paq 'neovim/nvim-lspconfig'
paq 'nvim-lua/completion-nvim'
paq 'nvim-lua/diagnostic-nvim'

paq 'nvim-treesitter/nvim-treesitter'
paq 'sheerun/vim-polyglot'

--Misc
paq 'tpope/vim-surround' -- Able to change [{()}]
paq 'RRethy/vim-illuminate'

-- Lanaguages
paq 'elzr/vim-json'
paq 'stephpy/vim-yaml'
paq 'PProvost/vim-ps1'

--  paq 'plasticboy/vim-markdown'
--  paq 'godlygeek/tabular'

-- View indenting
--  paq 'Yggdroot/indentLine'

-- WordJumping like resharper and faster movement
-- paq 'bkad/CamelCaseMotion'
paq 'easymotion/vim-easymotion'

-- Convenience for commenting things in and out
paq 'scrooloose/nerdcommenter'

-- Auto close parens, braces, brackets, etc
paq 'jiangmiao/auto-pairs'

-- Looks
paq 'mhinz/vim-startify'
paq 'ryanoasis/vim-devicons'
paq 'kyazdani42/nvim-web-devicons'
paq 'vim-airline/vim-airline'
paq 'vim-airline/vim-airline-themes'

-- Git feedback in files
paq 'airblade/vim-gitgutter'
paq 'tpope/vim-fugitive'

-- Focus mode
paq 'junegunn/goyo.vim'
paq 'junegunn/limelight.vim'

-- paq 'tjdevries/cyclist.vim'

-- DevOps Stuff
paq 'hashivim/vim-terraform'
paq 'hashicorp/terraform-ls'

-- Linting error support for js,ts
--  paq 'desmap/ale-sensible'
--  paq 'w0rp/ale', { 'for': ['typescript', 'javascript'] }