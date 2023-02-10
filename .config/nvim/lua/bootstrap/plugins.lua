local hostname = vim.loop.os_gethostname()
local isWorkMacbook = string.find(hostname, "AMS")

local nullLs = { "jose-elias-alvarez/null-ls.nvim" }
if isWorkMacbook then
  nullLs = { "jose-elias-alvarez/null-ls.nvim", commit = "76d0573fc159839a9c4e62a0ac4f1046845cdd50" }
end

require("lazy").setup {
  nullLs,
  -- Colorscheme
  -- use "Shatur/neovim-ayu"
  -- use "LunarVim/github.nvim"
  "fenetikm/falcon",
  { "ellisonleao/gruvbox.nvim", lazy = true },
  { "tjdevries/gruvbuddy.nvim", dependencies = "tjdevries/colorbuddy.vim" },
  "projekt0n/github-nvim-theme",

  -- Telescope
  "nvim-telescope/telescope.nvim",
  { "ThePrimeagen/git-worktree.nvim", lazy = true },
  "nvim-telescope/telescope-ui-select.nvim",
  { "LukasPietzschmann/telescope-tabs", lazy = true },
  { "nvim-telescope/telescope-file-browser.nvim", lazy = true },
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  { "axkirillov/easypick.nvim", lazy = true },

  -- treesitter
  { "nvim-treesitter/playground", lazy = true },
  { "nvim-treesitter/nvim-treesitter", lazy = true },
  "nvim-treesitter/nvim-treesitter-textobjects",
  { "JoosepAlviste/nvim-ts-context-commentstring", lazy = true },
  { "s1n7ax/nvim-comment-frame", event = "VeryLazy" },

  -- LSP config
  "neovim/nvim-lspconfig",
  "onsails/lspkind-nvim",
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-nvim-lsp",
  "tami5/lspsaga.nvim", -- look into creating myown hovers,
  "j-hui/fidget.nvim",
  { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim" },
  { "https://git.sr.ht/~whynothugo/lsp_lines.nvim", name = "lsp_lines.nvim" },
  { "SmiteshP/nvim-navic", lazy = true },

  "ray-x/lsp_signature.nvim",
  "nvim-lua/lsp_extensions.nvim",
  { "simrat39/inlay-hints.nvim", lazy = true },

  -- Utils
  { "kyazdani42/nvim-tree.lua", lazy = true, event = "VeryLazy" },
  "phaazon/hop.nvim",
  { "ellisonleao/glow.nvim", lazy = true },
  "nvim-lua/popup.nvim",
  "nvim-lua/plenary.nvim",
  { "stevearc/dressing.nvim", event = "VeryLazy" },
  "unblevable/quick-scope",
  -- "ThePrimeagen/harpoon",
  { "rmagatti/alternate-toggler", lazy = false },
  { "ThePrimeagen/refactoring.nvim", lazy = false },
  "m4xshen/autoclose.nvim",

  { "numToStr/Comment.nvim", lazy = true },
  -- "rcarriga/nvim-notify",
  { "anuvyklack/hydra.nvim", lazy = true },
  "norcalli/nvim-colorizer.lua",

  -- Glepnir
  -- "glepnir/zephyr-nvim",
  { "glepnir/template.nvim", lazy = true },
  -- 'glepnir/coman.nvim',
  -- 'bkad/CamelCaseMotion' -- WordJumping like resharper and faster movement,

  -- Searching
  { "google/vim-searchindex", lazy = true },
  { "windwp/nvim-spectre", lazy = true },

  -- sessions
  { "rmagatti/session-lens", lazy = true },
  { "rmagatti/auto-session", lazy = true },

  -- Lanaguages
  "elzr/vim-json",
  "jidn/vim-dbml",
  "stephpy/vim-yaml",
  "PProvost/vim-ps1",
  "ekalinin/Dockerfile.vim",

  --  Markdown
  { "godlygeek/tabular", lazy = true },
  { "plasticboy/vim-markdown", lazy = true },
  { "dhruvasagar/vim-table-mode", lazy = true },

  -- Looks
  "lewis6991/gitsigns.nvim",
  "tjdevries/express_line.nvim",
  "lukas-reineke/indent-blankline.nvim",

  -- Icons
  "kyazdani42/nvim-web-devicons",

  -- My plugins
  "koenverburg/peepsight.nvim",
  "koenverburg/cmd-palette.nvim",
  "koenverburg/minimal-tabline.nvim",
  "koenverburg/dim.lua", -- Fork,
  "koenverburg/nebulous.nvim", -- Fork,
  { dir = "~/code/github/nightcoder.nvim" },

  -- Git
  { "TimUntersberger/neogit", lazy = true },
  { "sindrets/diffview.nvim", lazy = true },
  -- "tjdevries/diff-therapy.nvim",

  -- Snippets
  { "L3MON4D3/LuaSnip", lazy = true },
  { "saadparwaiz1/cmp_luasnip", lazy = true },
  { "nyngwang/murmur.lua", lazy = true },

  "gen740/SmoothCursor.nvim",

  -- AI
  {
    "Exafunction/codeium.vim",
    config = function()
      -- Change '<C-g>' here to any keycode you like.
      vim.keymap.set("i", "<C-g>", function()
        return vim.fn["codeium#Accept"]()
      end, { expr = true })
      vim.keymap.set("i", "<c-;>", function()
        return vim.fn["codeium#CycleCompletions"](1)
      end, { expr = true })
      vim.keymap.set("i", "<c-,>", function()
        return vim.fn["codeium#CycleCompletions"](-1)
      end, { expr = true })
      vim.keymap.set("i", "<c-x>", function()
        return vim.fn["codeium#Clear"]()
      end, { expr = true })
    end,
  },
}
