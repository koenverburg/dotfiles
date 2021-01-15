local repo = 'https://github.com/wbthomason/packer.nvim'
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'

vim.o.packpath = vim.o.packpath .. vim.fn.stdpath('data')
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  print 'Downloading Packer..'
  vim.api.nvim_command(string.format('!git clone %s "%s"', repo, install_path))
end

vim.api.nvim_command 'packadd packer.nvim'
-- require('packer').init()
return require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  use 'junegunn/vim-plug'
  use 'sheerun/vim-polyglot'

  -- Colorscheme
  use 'trusktr/seti.vim'
  use 'ajmwagar/vim-deus'
  use 'glepnir/zephyr-nvim'
  use 'christianchiarulli/nvcode-color-schemes.vim'

  -- Finders
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'
  use 'mileszs/ack.vim'
  use 'junegunn/fzf'
  use 'junegunn/fzf.vim'
  use 'gfanto/fzf-lsp.nvim'

  -- LSP config
  use 'neovim/nvim-lsp'
  use 'neovim/nvim-lspconfig'
  use 'nvim-lua/completion-nvim'
  use 'nvim-lua/diagnostic-nvim'

  use 'nvim-treesitter/nvim-treesitter'

  --Misc
  use 'tpope/vim-surround' -- Able to change [{()}]
  use 'RRethy/vim-illuminate'

  -- Lanaguages
  use 'elzr/vim-json'
  use 'stephpy/vim-yaml'
  use 'PProvost/vim-ps1'
  --  use 'plasticboy/vim-markdown'
  --  use 'godlygeek/tabular'

  -- View indenting
  --  use 'Yggdroot/indentLine'

  -- WordJumping like resharper and faster movement
  -- use 'bkad/CamelCaseMotion'
  use 'easymotion/vim-easymotion'

  -- Convenience for commenting things in and out
  use 'scrooloose/nerdcommenter'

  -- Auto close parens, braces, brackets, etc
  use 'jiangmiao/auto-pairs'

  -- Looks
  use 'mhinz/vim-startify'
  use 'ryanoasis/vim-devicons'
  use 'kyazdani42/nvim-web-devicons'
  use 'vim-airline/vim-airline'
  use 'vim-airline/vim-airline-themes'
  -- use 'glepnir/galaxyline.nvim'

  -- Git feedback in files
  use 'airblade/vim-gitgutter'
  use 'tpope/vim-fugitive'

  -- Focus mode
  use 'junegunn/goyo.vim'
  use 'junegunn/limelight.vim'

  -- use 'tjdevries/cyclist.vim'

  -- DevOps Stuff
  use 'hashivim/vim-terraform'
  use 'hashicorp/terraform-ls'
  -- Linting error support for js,ts
  --  use 'desmap/ale-sensible'
  --  use 'w0rp/ale', { 'for': ['typescript', 'javascript'] }


end)
