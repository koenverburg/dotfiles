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
    use 'junegunn/fzf'
    use 'junegunn/fzf.vim'
    use 'scrooloose/nerdtree'

    -- LSP config
    use 'neovim/nvim-lsp'
    use 'neovim/nvim-lspconfig'
    use 'nvim-lua/completion-nvim'
    use 'nvim-lua/diagnostic-nvim'
    use 'onsails/lspkind-nvim'

    -- Snippets
    --use 'SirVer/ultisnips'
    --use 'honza/vim-snippets'

    use 'nvim-treesitter/nvim-treesitter'

    -- Misc
    use 'tpope/vim-surround' -- Able to change [{()}]""''
    use 'RRethy/vim-illuminate'

    -- Lanaguages
    use 'elzr/vim-json'
    use 'stephpy/vim-yaml'
    use 'PProvost/vim-ps1'
    use 'hashivim/vim-terraform'
    use 'hashicorp/terraform-ls'

    --  use 'plasticboy/vim-markdown'
    --  use 'godlygeek/tabular'

    -- WordJumping like resharper and faster movement
    -- use 'bkad/CamelCaseMotion'
    -- use 'easymotion/vim-easymotion'

    -- Convenience for commenting things in and out
    use 'scrooloose/nerdcommenter'

    -- Auto close parens, braces, brackets, etc
    use 'jiangmiao/auto-pairs'

    -- Looks
    use 'mhinz/vim-startify'
    use 'ryanoasis/vim-devicons'
    use 'kyazdani42/nvim-web-devicons'
    use 'hoob3rt/lualine.nvim'

    -- Git feedback in files
    -- use 'airblade/vim-gitgutter'
    use 'mhinz/vim-signify'
    use 'tpope/vim-fugitive'

    -- Focus mode
    use 'junegunn/goyo.vim'
    use 'junegunn/limelight.vim'
    use 'kyazdani42/nvim-tree.lua' 

    -- Linting error support for js,ts
    --  use 'w0rp/ale'
    --  use 'desmap/ale-sensible'
  end
}
