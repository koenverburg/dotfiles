return require("packer").startup {
  function(use)
    -- use 'tweekmonster/startuptime.vim'
    use { "wbthomason/packer.nvim", opt = true }

    -- Colorscheme
    use "doums/darcula"
    use "Shatur/neovim-ayu"
    use "glepnir/zephyr-nvim"
    use "Yagua/nebulous.nvim"
    use { "tjdevries/gruvbuddy.nvim", requires = "tjdevries/colorbuddy.vim" }

    -- Telescope
    use "nvim-telescope/telescope.nvim"
    use "ThePrimeagen/git-worktree.nvim"
    use "nvim-telescope/telescope-ui-select.nvim"
    use "nvim-telescope/telescope-file-browser.nvim"
    use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }

    -- treesitter
    use "nvim-treesitter/playground"
    use "nvim-treesitter/nvim-treesitter"
    use "nvim-treesitter/nvim-treesitter-textobjects"
    use "JoosepAlviste/nvim-ts-context-commentstring"

    -- LSP config
    use "neovim/nvim-lspconfig"
    use "onsails/lspkind-nvim"
    use "hrsh7th/nvim-cmp"
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-nvim-lsp"
    use "tami5/lspsaga.nvim"
    use "ray-x/lsp_signature.nvim"
    use "nvim-lua/lsp_extensions.nvim"
    use "j-hui/fidget.nvim"

    -- Utils
    use "sindrets/diffview.nvim"
    use "windwp/nvim-autopairs"
    use "kyazdani42/nvim-tree.lua"
    use "phaazon/hop.nvim"
    use "ellisonleao/glow.nvim"
    use "nvim-lua/popup.nvim"
    use "nvim-lua/plenary.nvim"
    use "stevearc/dressing.nvim"
    use "glepnir/smartinput.nvim"
    use "unblevable/quick-scope"
    use "google/vim-searchindex"
    use "ruifm/gitlinker.nvim"
    use "lewis6991/impatient.nvim"
    use "rmagatti/alternate-toggler"
    use "ThePrimeagen/refactoring.nvim"
    use "ThePrimeagen/harpoon"
    use "jose-elias-alvarez/null-ls.nvim"
    use "numToStr/Comment.nvim"
    use "rcarriga/nvim-notify"
    use "simrat39/symbols-outline.nvim"
    -- use "sunjon/shade.nvim"
    -- use 'glepnir/prodoc.nvim'
    -- use 'bkad/CamelCaseMotion' -- WordJumping like resharper and faster movement

    -- sessions
    use "rmagatti/session-lens"
    use "rmagatti/auto-session"

    -- Misc
    use "RRethy/vim-illuminate"

    -- Lanaguages
    use "elzr/vim-json"
    use "jidn/vim-dbml"
    use "stephpy/vim-yaml"
    use "PProvost/vim-ps1"
    use "ekalinin/Dockerfile.vim"

    --  Markdown
    use "godlygeek/tabular"
    use "plasticboy/vim-markdown"
    use "dhruvasagar/vim-table-mode"

    -- Looks
    use "lewis6991/gitsigns.nvim"
    -- use "nvim-lualine/lualine.nvim"
    use "tjdevries/express_line.nvim"

    -- Icons
    use "ryanoasis/vim-devicons"
    use "kyazdani42/nvim-web-devicons"

    -- My plugins
    use "koenverburg/minimal-tabline.nvim"
    use "koenverburg/peepsight.nvim"
    use "koenverburg/cmd-palette.nvim"
    -- use "koenverburg/virtual-types.nvim"

    -- Snippets
    use "L3MON4D3/LuaSnip"
    use "saadparwaiz1/cmp_luasnip"
  end,
  config = {
    -- Move to lua dir so impatient.nvim can cache it
    compile_path = vim.fn.stdpath "config" .. "/lua/packer_compiled.lua",
    display = {
      open_fn = function()
        return require("packer.util").float { border = "single" }
      end,
    },
  },
}
