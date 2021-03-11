-- On ly required if you have packer in your `opt` pack
local packer_exists = pcall(vim.cmd, [[packadd packer.nvim]])

if not packer_exists then
  -- TODO: Maybe handle windows better?
  if vim.fn.input("Download Packer? (y for yes)") ~= "y" then
    return
  end

  local directory = string.format(
    '%s/site/pack/packer/opt/',
    vim.fn.stdpath('data')
  )

  vim.fn.mkdir(directory, 'p')

  local out = vim.fn.system(string.format(
    'git clone %s "%s"',
    'https://github.com/wbthomason/packer.nvim',
    directory .. '/packer.nvim'
  ))

  print(out)
  print("Downloading packer.nvim...")
  print("( You'll need to restart now )")

  return
end

return require('packer').startup {
  function(use)
    -- use 'tweekmonster/startuptime.vim'
    use {'wbthomason/packer.nvim', opt = true}

    -- Colorscheme
    use 'glepnir/zephyr-nvim'
    use 'christianchiarulli/nvcode-color-schemes.vim'

    -- Finders / UI
    use 'nvim-lua/popup.nvim'
    use 'nvim-lua/plenary.nvim'
    use 'nvim-telescope/telescope.nvim'
    use 'nvim-telescope/telescope-fzy-native.nvim'
    use 'scrooloose/nerdtree'

    -- LSP config
    use 'neovim/nvim-lspconfig'
    use 'nvim-lua/completion-nvim'
    use 'nvim-lua/diagnostic-nvim'
    use 'wbthomason/lsp-status.nvim'
    use 'onsails/lspkind-nvim'
    use 'glepnir/lspsaga.nvim'
    --use 'tjdevries/nlua.nvim'

    -- Snippets
    --use 'SirVer/ultisnips'

    use 'nvim-treesitter/nvim-treesitter'

    -- Misc
    use 'tpope/vim-surround' -- Able to change [{()}]""''
    use 'tpope/vim-fugitive'
    use 'RRethy/vim-illuminate'
    use 'jiangmiao/auto-pairs'

    -- Lanaguages
    use 'elzr/vim-json'
    use 'stephpy/vim-yaml'
    use 'PProvost/vim-ps1'
    use 'hashivim/vim-terraform'
    use 'hashicorp/terraform-ls'
    use 'ekalinin/Dockerfile.vim'

    --  Markdown
    use 'Iron-E/nvim-libmodal'
    use 'Iron-E/nvim-typora'
    use 'plasticboy/vim-markdown'
    use 'godlygeek/tabular'

    use 'easymotion/vim-easymotion'
    -- use 'bkad/CamelCaseMotion' -- WordJumping like resharper and faster movement

    -- Convenience for commenting things in and out
    use 'scrooloose/nerdcommenter'

    -- Looks
    use 'mhinz/vim-startify'
    use 'tjdevries/express_line.nvim'
    use 'kyazdani42/nvim-web-devicons'
    use 'ryanoasis/vim-devicons'
    use 'airblade/vim-gitgutter'

    -- Focus mode
    use 'junegunn/goyo.vim'
    use 'junegunn/limelight.vim'

    -- linting
    use 'w0rp/ale'
  end
}
