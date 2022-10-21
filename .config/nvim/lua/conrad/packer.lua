return require("packer").startup {
  function(use)
    local local_use = function(name, opts)
      opts = opts or {}

      github_path = "~/code/github/"

      if vim.fn.isdirectory(vim.fn.expand(github_path .. name)) == 1 then
         opts[1] = string.format("%s/%s", github_path, name)
      end

      use(opts)
    end

    -- use 'tweekmonster/startuptime.vim'
    use { "wbthomason/packer.nvim", opt = true }

    -- Colorscheme
    use "Shatur/neovim-ayu"
    use "glepnir/zephyr-nvim"
    use "koenverburg/nebulous.nvim"
    use "ellisonleao/gruvbox.nvim"
    use { "tjdevries/gruvbuddy.nvim", requires = "tjdevries/colorbuddy.vim" }
    use { "catppuccin/nvim", as = "catppuccin" }

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
    use "s1n7ax/nvim-comment-frame"

    -- LSP config
    use "neovim/nvim-lspconfig"
    use "onsails/lspkind-nvim"
    use "hrsh7th/nvim-cmp"
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-nvim-lsp"
    use "tami5/lspsaga.nvim" -- look into creating myown hovers
    use "j-hui/fidget.nvim"
    use { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim" }

    use "ray-x/lsp_signature.nvim"
    use "nvim-lua/lsp_extensions.nvim"
    use "simrat39/inlay-hints.nvim"

    -- Christian / LunarVim
    -- use "LunarVim/peek.lua"

    -- Utils
    use "windwp/nvim-autopairs"
    use "kyazdani42/nvim-tree.lua"
    use "phaazon/hop.nvim"
    use "ellisonleao/glow.nvim"
    use "nvim-lua/popup.nvim"
    use "nvim-lua/plenary.nvim"
    use "stevearc/dressing.nvim"
    use "glepnir/smartinput.nvim"
    use "unblevable/quick-scope"
    -- use "ThePrimeagen/harpoon"
    use "lewis6991/impatient.nvim"
    use "rmagatti/alternate-toggler"
    use "ThePrimeagen/refactoring.nvim"
    use "jose-elias-alvarez/null-ls.nvim"
    use "numToStr/Comment.nvim"
    use "rcarriga/nvim-notify"
    -- use "stevearc/aerial.nvim"
    use 'anuvyklack/hydra.nvim'
    use 'norcalli/nvim-colorizer.lua'
    -- use 'levouh/tint.nvim'
    -- use 'bkad/CamelCaseMotion' -- WordJumping like resharper and faster movement

    -- Searching
    use "google/vim-searchindex"
    use "windwp/nvim-spectre"

    -- sessions
    -- use 'jedrzejboczar/possession.nvim'
    use "rmagatti/session-lens"
    use "rmagatti/auto-session"

    -- Misc
    use "RRethy/vim-illuminate" -- can be removed lsp should have support for this
    -- use "nathom/filetype.nvim"

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
    use "tjdevries/express_line.nvim"

    -- Icons
    use "kyazdani42/nvim-web-devicons"

    -- My plugins
    use "koenverburg/peepsight.nvim"
    use "koenverburg/cmd-palette.nvim"
    use "koenverburg/minimal-tabline.nvim"
    use "koenverburg/dim.lua" -- Fork

    -- Git
    use "TimUntersberger/neogit"
    use "sindrets/diffview.nvim"
    -- use "tjdevries/diff-therapy.nvim"

    -- Snippets
    use "L3MON4D3/LuaSnip"
    use "saadparwaiz1/cmp_luasnip"

    -- in dev plugins
    -- local_use('nightcoder.nvim')
    -- _= vim.cmd [[ packadd ~/code/github/nightcoder.nvim ]]
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
