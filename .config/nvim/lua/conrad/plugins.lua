-- Only required if you have packer in your `opt` pack
local packer_exists = pcall(vim.cmd, [[packadd packer.nvim]])

if not packer_exists then
  if vim.fn.input('Download Packer? (y for yes)') ~= 'y' then
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
  print('Downloading packer.nvim...')
  print("( You'll need to restart now )")

  return
end

return require('packer').startup {
  function(use)
    -- use 'tweekmonster/startuptime.vim'
    use {'wbthomason/packer.nvim', opt = true}

    -- Colorscheme
    use 'glepnir/zephyr-nvim'
    use 'Yagua/nebulous.nvim'
    use { 'tjdevries/gruvbuddy.nvim', requires = 'tjdevries/colorbuddy.vim' }
    use { 'briones-gabriel/darcula-solid.nvim', requires = 'rktjmp/lush.nvim' }

    -- Telescope
    use 'nvim-telescope/telescope.nvim'
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    use 'ThePrimeagen/git-worktree.nvim'
    use {
      'nvim-telescope/telescope-frecency.nvim',
      requires = {"tami5/sqlite.lua"}
    }

    -- Old
    use 'scrooloose/nerdtree'

    -- treesitter
    use 'nvim-treesitter/playground'
    use 'nvim-treesitter/nvim-treesitter'
    use 'nvim-treesitter/nvim-treesitter-textobjects'
    use 'JoosepAlviste/nvim-ts-context-commentstring'

    -- LSP config
    use 'neovim/nvim-lspconfig'
    use 'onsails/lspkind-nvim'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/nvim-cmp'
    use 'tami5/lspsaga.nvim'
    use 'ray-x/lsp_signature.nvim'
    --use 'tjdevries/nlua.nvim'

    -- Utils
    use 'google/vim-searchindex'
    use 'tjdevries/cyclist.vim'
    use 'nvim-lua/popup.nvim'
    use 'nvim-lua/plenary.nvim'
    use 'glepnir/prodoc.nvim'
    use 'phaazon/hop.nvim'
    use 'unblevable/quick-scope'
    use 'rmagatti/alternate-toggler'
    use 'ThePrimeagen/refactoring.nvim'
    use 'ThePrimeagen/harpoon'
    use {
      'lewis6991/impatient.nvim',
      config = function()
        require('impatient')
      end
    }
    -- use 'bkad/CamelCaseMotion' -- WordJumping like resharper and faster movement

    -- sessions
    use {
      'rmagatti/session-lens',
      requires = {'rmagatti/auto-session'},
      config = function()
        require('session-lens').setup()
      end
    }

    -- Misc
    use 'tpope/vim-surround' -- Able to change [{()}]""''
    use 'tpope/vim-commentary'
    use 'RRethy/vim-illuminate'
    use 'tjdevries/astronauta.nvim'
    use 'jiangmiao/auto-pairs' -- not working in lua??? -- fix this during the stream

    -- Lanaguages
    use 'elzr/vim-json'
    use 'stephpy/vim-yaml'
    use 'PProvost/vim-ps1'
    use 'ekalinin/Dockerfile.vim'
    use 'jidn/vim-dbml'

    --  Markdown
    use 'godlygeek/tabular'
    use 'plasticboy/vim-markdown'
    use 'dhruvasagar/vim-table-mode'

    -- Looks
    use 'lewis6991/gitsigns.nvim'
    use 'tjdevries/express_line.nvim'

    -- Icons
    use 'ryanoasis/vim-devicons'
    use 'kyazdani42/nvim-web-devicons'

    -- Focus mode
    use 'folke/twilight.nvim'
    use 'folke/zen-mode.nvim'

    -- Formatting
    use 'mhartington/formatter.nvim'

    -- Snippets
    use 'hrsh7th/vim-vsnip'
    use 'hrsh7th/vim-vsnip-integ'

  end,
  config = {
    -- Move to lua dir so impatient.nvim can cache it
    compile_path = vim.fn.stdpath('config')..'/lua/packer_compiled.lua',
    display = {
      open_fn = function()
        return require('packer.util').float({ border = 'single' })
      end
    }
  }
}

