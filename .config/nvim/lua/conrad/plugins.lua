-- Only required if you have packer in your `opt` pack
local packer_exists = pcall(vim.cmd, [[packadd packer.nvim]])

if not packer_exists then
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
    use { 'briones-gabriel/darcula-solid.nvim', requires = 'rktjmp/lush.nvim' }

    -- Telescope
    use 'nvim-telescope/telescope.nvim'
    use { 'ThePrimeagen/git-worktree.nvim', as = 'gitworktree' }
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    use 'scrooloose/nerdtree' -- trying to phase this one out

    -- treesitter
    use 'nvim-treesitter/nvim-treesitter-textobjects'
    use 'JoosepAlviste/nvim-ts-context-commentstring'

    -- LSP config
    use 'neovim/nvim-lspconfig'
    use 'nvim-lua/completion-nvim'
    use 'onsails/lspkind-nvim'
    use 'glepnir/lspsaga.nvim'
    --use 'tjdevries/nlua.nvim'

    -- Utils
    use 'nvim-lua/popup.nvim'
    use 'nvim-lua/plenary.nvim'
    use 'glepnir/prodoc.nvim'
    use 'nvim-treesitter/nvim-treesitter'
    use 'phaazon/hop.nvim'
    use 'unblevable/quick-scope'
    use 'rmagatti/alternate-toggler'

    -- Misc
    use 'tpope/vim-surround' -- Able to change [{()}]""''
    use 'tpope/vim-fugitive'
    use 'tpope/vim-commentary'
    use 'RRethy/vim-illuminate'
    -- use 'jiangmiao/auto-pairs' -- not working in lua??? -- fix this during the stream
    -- use 'tjdevries/astronauta.nvim'

    -- Lanaguages
    use 'elzr/vim-json'
    use 'stephpy/vim-yaml'
    use 'PProvost/vim-ps1'
    -- use 'hashivim/vim-terraform'
    -- use 'hashicorp/terraform-ls'
    use 'ekalinin/Dockerfile.vim'
    use 'jidn/vim-dbml'

    --  Markdown
    use 'godlygeek/tabular'
    use 'plasticboy/vim-markdown'
    use 'dhruvasagar/vim-table-mode'

    -- use 'bkad/CamelCaseMotion' -- WordJumping like resharper and faster movement

    -- Looks
    use 'mhinz/vim-startify'
    use 'lewis6991/gitsigns.nvim'
    use 'tjdevries/express_line.nvim'

    -- Icons
    use 'ryanoasis/vim-devicons'
    use 'kyazdani42/nvim-web-devicons'

    -- Focus mode
    use 'junegunn/goyo.vim'
    use 'junegunn/limelight.vim'

    -- Formatting
    use 'mhartington/formatter.nvim'

    -- Snippets
    use 'norcalli/snippets.nvim'

  end
}
