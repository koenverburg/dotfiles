is_enabled = require("_apache.functions").is_enabled
local core = require("_apache.core")
-- 'bkad/CamelCaseMotion' -- WordJumping like resharper and faster movement,
return {
  {
    "nullchilly/fsread.nvim",
    enabled = false, --is_enabled("misc"),
    lazy = true,
    config = function() end,
  },
  {
    "rmagatti/alternate-toggler",
    enabled = is_enabled("misc"),
    lazy = false,
    config = function() end,
  },
  {
    "unblevable/quick-scope",
    enabled = is_enabled("misc"),
    lazy = false,
    config = function() end,
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
    enabled = is_enabled("misc"),
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
    end,
  },
  {
    "nyngwang/murmur.lua",
    enabled = is_enabled("murmur"),
    lazy = false,
    config = function()
      require("murmur").setup({})
      vim.api.nvim_set_hl(0, "murmur_cursor_rgb", { fg = core.colors.black, bg = core.colors.black })
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
        { "h", "<C-w>h" },
        { "j", "<C-w>j" },
        { "k", "<C-w>k" },
        { "l", "<C-w>l" },

        -- resizing window
        { "H", "<C-w>3<" },
        { "L", "<C-w>3>" },
        { "K", "<C-w>2+" },
        { "J", "<C-w>2-" },

        -- equalize window sizes
        { "e", "<C-w>=" },

        -- close active window
        { "Q", ":q<cr>" },
        { "<C-q>", ":q<cr>" },

        -- exit this Hydra
        { "q", nil, { exit = true, nowait = true } },
        { ";", nil, { exit = true, nowait = true } },
        { "<Esc>", nil, { exit = true, nowait = true } },
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
    "folke/persistence.nvim",
    enabled = is_enabled("persistence"),
    lazy = false,
    event = "BufReadPre", -- this will only start session saving when an actual file was opened
    config = function()
      require("persistence").setup({
        dir = vim.fn.expand(vim.fn.stdpath("data") .. "/sessions/"), -- directory where session files are saved
        options = { "buffers", "curdir", "tabpages" }, -- sessionoptions used for saving
        -- pre_save = nil, -- a function to call before saving the session
      })
    end,
  },
}
