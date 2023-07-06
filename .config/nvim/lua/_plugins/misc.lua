local is_enabled = require("_apache.functions").is_enabled
local core = require("_apache.core")
-- 'bkad/CamelCaseMotion' -- WordJumping like resharper and faster movement,
return {
  {
    "nullchilly/fsread.nvim",
    enabled = true, --is_enabled("misc"),
    lazy = true,
    config = function()
    end,
  },
  {
    "rmagatti/alternate-toggler",
    enabled = is_enabled("misc"),
    lazy = false,
    config = function()
      require("alternate-toggler").setup {
        alternates = {
          ["dev"] = "prod",
          ["prod"] = "dev",

          ["development"] = "production",
          ["production"] = "development",

          ["live"] = "backtest",
          ["backtest"] = "live",

          ["==="] = "!==",
          ["=="] = "!=",
        }
      }
    end,
  },
  {
    "unblevable/quick-scope",
    enabled = is_enabled("misc"),
    lazy = false,
    config = function()
    end,
  },
  {
    "koenverburg/dim.lua", -- Fork,
    enabled = is_enabled("misc"),
    lazy = true,
    config = function()
      require("dim").setup()
    end,
  },
  {
    "norcalli/nvim-colorizer.lua",
    enabled = is_enabled("colorizer"),
    lazy = false,
    config = function()
      require("colorizer").setup()
    end,
  },
  {
    "phaazon/hop.nvim",
    enabled = is_enabled("hop"),
    lazy = false,
    config = function()
      require("hop").setup()
    end,
  },
  {
    "numToStr/Comment.nvim",
    enabled = is_enabled("comment"),
    lazy = false,
    config = function()
      require("Comment").setup()
      local comment_ft = require "Comment.ft"
      comment_ft.set("lua", { "--%s", "--[[%s]]" })

      comment_ft.set('json', { "// %s"})
      comment_ft.set("javascriptreact", { "// %s" })
      comment_ft.set("typescriptreact", { "// %s" })
    end,
  },
  {
    "RRethy/vim-illuminate",
    enabled = is_enabled("cursorword"),
    lazy = false,
    opts = {
      providers = {
        'lsp',
        'treesitter',
        'regex',
      },
      -- delay: delay in milliseconds
      delay = 100,
      -- filetype_overrides: filetype specific overrides.
      -- The keys are strings to represent the filetype while the values are tables that
      -- supports the same keys passed to .configure except for filetypes_denylist and filetypes_allowlist
      filetype_overrides = {},
      -- filetypes_denylist: filetypes to not illuminate, this overrides filetypes_allowlist
      filetypes_denylist = {
        'dirvish',
        'fugitive',
      },
      -- filetypes_allowlist: filetypes to illuminate, this is overriden by filetypes_denylist
      filetypes_allowlist = {},
      -- modes_denylist: modes to not illuminate, this overrides modes_allowlist
      -- See `:help mode()` for possible values
      modes_denylist = {},
      -- modes_allowlist: modes to illuminate, this is overriden by modes_denylist
      -- See `:help mode()` for possible values
      modes_allowlist = {},
      -- providers_regex_syntax_denylist: syntax to not illuminate, this overrides providers_regex_syntax_allowlist
      -- Only applies to the 'regex' provider
      -- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
      providers_regex_syntax_denylist = {},
      -- providers_regex_syntax_allowlist: syntax to illuminate, this is overriden by providers_regex_syntax_denylist
      -- Only applies to the 'regex' provider
      -- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
      providers_regex_syntax_allowlist = {},
      -- under_cursor: whether or not to illuminate under the cursor
      under_cursor = true,
      -- large_file_cutoff: number of lines at which to use large_file_config
      -- The `under_cursor` option is disabled when this cutoff is hit
      large_file_cutoff = nil,
      -- large_file_config: config to use for large files (based on large_file_cutoff).
      -- Supports the same keys passed to .configure
      -- If nil, vim-illuminate will be disabled for large files.
      large_file_overrides = nil,
      -- min_count_to_highlight: minimum number of matches required to perform highlighting
      min_count_to_highlight = 1,
    },
    config = function(_, opts)
      require("illuminate").configure(opts)
      local colors = {
        -- guifg = nil,
        -- guibg = nil,

        guifg= core.colors.yellow,
        guibg = core.colors.black,
        fg = core.colors.yellow,
        bg = core.colors.black,
        guisp = 'pink'
      }

      vim.cmd [[highlight! link IlluminatedWordText LspReferenceText]]
      vim.cmd [[highlight! link IlluminatedWordRead LspReferenceRead]]
      vim.cmd [[highlight! link IlluminatedWordWrite LspReferenceWrite]]

      -- vim.api.nvim_set_hl(0, "IlluminateWord", colors)
      -- vim.api.nvim_set_hl(0, "IlluminateWordText", colors)
      -- vim.api.nvim_set_hl(0, "IlluminateWordRead", colors)
      -- vim.api.nvim_set_hl(0, "IlluminateWordWrite", colors)
      -- vim.api.nvim_set_hl(0, "CursorWord", {
      --   default = 1,
      --   fg = core.colors.black,
      --   guifb = core.colors.black,
      --   bg = core.colors.black,
      --   guibg = core.colors.black
      -- })
      -- vim.api.nvim_create_autocmd({ 'ColorScheme' }, {
      --   callback = function()
      --     -- vim.api.nvim_set_hl(0, "murmur_cursor_rgb", { fg = "#0a100d", bg = "#ffee32" })
      --     vim.api.nvim_set_hl(0, "murmur_cursor_rgb", { fg = core.colors.black, bg = core.colors.black })
      --   end
      -- })
    end,
  },
  {
    -- doesnt really work??
    "m4xshen/autoclose.nvim",
    enabled = is_enabled("misc"),
    lazy = false,
    config = function()
      require("autoclose").setup({
        ["<"] = { escape = true, close = true, pair = "<>" },
      })
    end,
  },
  {
    "levouh/tint.nvim",
    enabled = is_enabled("tint"),
    lazy = false,
    opts = {
      tint = -60,
      -- saturation = 1,  -- Saturation to preserve
      -- transforms = require("tint").transforms.SATURATE_TINT,  -- Showing default behavior, but value here can be predefined set of transforms
      tint_background_colors = false, -- Tint background portions of highlight groups
      highlight_ignore_patterns = { "WinSeparator", "Status.*" },
    },
    config = function(_, opts)
      require("tint").setup(opts)
    end,
  },
  {
    "rainbowhxch/accelerated-jk.nvim",
    enabled = is_enabled("accelerated-jk"),
    lazy = false,
    opts = {
      mode = "time_driven",
      enable_deceleration = true,
      acceleration_motions = {},
      acceleration_limit = 150,
      acceleration_table = { 2, 7, 26, 28, 30 },
      -- acceleration_table = { 2, 7, 12, 17, 21, 24, 26, 28, 30 },
      -- when 'enable_deceleration = true',
      deceleration_table = { { 200, 3 }, { 300, 7 }, { 450, 11 }, { 600, 15 }, { 750, 21 }, { 900, 9999 } },
      -- deceleration_table = { { 150, 9999 } },
    },
    config = function(_, opts)
      require("accelerated-jk").setup(opts)
    end,
  },
  {
    "anuvyklack/hydra.nvim",
    enabled = is_enabled("hydra"),
    lazy = false,
    opts = {
      name = "Change / Resize Window",
      mode = { "n" },
      body = "<leader>w",
      config = {
        -- color = "pink",
      },
      heads = {
        -- move between windows
        { "h",     "<C-w>h" },
        { "j",     "<C-w>j" },
        { "k",     "<C-w>k" },
        { "l",     "<C-w>l" },

        -- resizing window
        { "H",     "<C-w>3<" },
        { "L",     "<C-w>3>" },
        { "K",     "<C-w>2+" },
        { "J",     "<C-w>2-" },

        -- equalize window sizes
        { "e",     "<C-w>=" },

        -- close active window
        { "Q",     ":q<cr>" },
        { "<C-q>", ":q<cr>" },

        -- exit this Hydra
        { "q",     nil,      { exit = true, nowait = true } },
        { ";",     nil,      { exit = true, nowait = true } },
        { "<Esc>", nil,      { exit = true, nowait = true } },
      },
    },
    config = function(_, opts)
      local hydra = require("hydra")
      hydra(opts)
    end,
  },
  {
    "glepnir/template.nvim",
    enabled = is_enabled("template"),
    config = function()
      local temp = require("template")
      temp.temp_dir = "~/.config/nvim/template"
      temp.author = "Koen Verburg (Conrad The Programmer)"
      temp.email = ""
    end,
  },
  {
    "junegunn/vim-easy-align",
    enabled = is_enabled('formatting'),
    lazy = false
  }
}
