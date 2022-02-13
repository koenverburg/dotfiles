-- Only required if you have packer in your `opt` pack
local packer_exists = pcall(vim.cmd, [[packadd packer.nvim]])
if not packer_exists then
  if vim.fn.input('Download Packer? (y for yes)') ~= 'y' then
    return
  end

  local directory = string.format('%s/site/pack/packer/opt/', vim.fn.stdpath('data'))
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
    use 'ThePrimeagen/git-worktree.nvim'
    use 'nvim-telescope/telescope-ui-select.nvim'
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

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
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'tami5/lspsaga.nvim'
    use 'ray-x/lsp_signature.nvim'

    -- Utils
    use 'phaazon/hop.nvim'
    use 'ellisonleao/glow.nvim'
    use 'nvim-lua/popup.nvim'
    use 'nvim-lua/plenary.nvim'
    use 'tjdevries/cyclist.vim'
    use 'unblevable/quick-scope'
    use 'google/vim-searchindex'
    use 'lewis6991/impatient.nvim'
    use 'rmagatti/alternate-toggler'
    use 'ThePrimeagen/refactoring.nvim'
    use 'ThePrimeagen/harpoon'
    use "jose-elias-alvarez/null-ls.nvim"
    use 'numToStr/Comment.nvim'
    -- use 'glepnir/prodoc.nvim'
    -- use 'bkad/CamelCaseMotion' -- WordJumping like resharper and faster movement

    -- sessions
    use 'rmagatti/session-lens'
    use 'rmagatti/auto-session'

    -- Misc
    use 'RRethy/vim-illuminate'
    use 'blackCauldron7/surround.nvim'
    -- use 'jiangmiao/auto-pairs' -- not working in lua??? -- fix this during the stream

    -- Lanaguages
    use 'elzr/vim-json'
    use 'jidn/vim-dbml'
    use 'stephpy/vim-yaml'
    use 'PProvost/vim-ps1'
    use 'ekalinin/Dockerfile.vim'
    use 'skanehira/preview-uml.vim' -- requires plantuml server to run via docker/podman

    --  Markdown
    use 'godlygeek/tabular'
    use 'plasticboy/vim-markdown'
    use 'dhruvasagar/vim-table-mode'

    -- Looks
    use 'lewis6991/gitsigns.nvim'
    use 'tjdevries/express_line.nvim'
    use 'koenverburg/minimal-tabline.nvim'

    -- Icons
    use 'ryanoasis/vim-devicons'
    use 'kyazdani42/nvim-web-devicons'

    -- Focus mode
    use 'folke/twilight.nvim'
    use 'folke/zen-mode.nvim'

    -- Snippets
    use 'L3MON4D3/LuaSnip'
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

