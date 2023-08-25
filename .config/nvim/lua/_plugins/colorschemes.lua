local is_enabled = require("_apache.functions").is_enabled
local core = require("_apache.core")

return {
  {
    "ellisonleao/gruvbox.nvim",
    enabled = is_enabled("gruvbox"),
    lazy = false,
    opts = {
      bold = true,
      undercurl = true,
      underline = true,
      italic = {
        folds = false,
        strings = false,
        comments = false,
        operators = false,
      },
      strikethrough = true,
      invert_signs = false,
      invert_tabline = false,
      invert_selection = false,
      invert_intend_guides = false,
      inverse = true, -- invert background for search, diffs, statuslines and errors
      contrast = "",  -- can be "hard", "soft" or empty string
      dim_inactive = false,
      transparent_mode = false,
      overrides = {},
      palette_overrides = {},
    },
    config = function(_, opts)
      vim.cmd("set background=light")
      require("gruvbox").setup(opts)
      vim.cmd("colorscheme gruvbox")
    end,
  },
  {
    "Yagua/nebulous.nvim",
    enabled = is_enabled("nebulous"),
    lazy = false,
    opts = {
      variant = "night", -- "night",
      -- variant = "quasar", -- "night",
    },
    config = function(_, opts)
      if not is_enabled("auto-colorscheme") then
        require("nebulous").setup(opts)
      end
    end,
  },
  {
    "aktersnurra/no-clown-fiesta.nvim",
    -- dir = "~/code/github/no-clown-fiesta.nvim",
    enabled = is_enabled("no-clown-fiesta"),
    lazy = false,
    opts = {
      transparent = false, -- Enable this to disable the bg color
      styles = {
        -- You can set any of the style values specified for `:h nvim_set_hl`
        comments = {},
        keywords = {},
        functions = { bold = true },
        variables = {},
        type = { bold = true },
        lsp = { underline = true },
      },
    },
    config = function(_, opts)
      if not is_enabled("auto-colorscheme") then
        require("no-clown-fiesta").setup(opts)
        vim.cmd([[colorscheme no-clown-fiesta]])
      end
    end,
  },
  {
    "lmburns/kimbox",
    enabled = is_enabled("kimbox"),
    lazy = false,
    config = function()
      require("kimbox").setup({
        style = "dark", -- choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
        -- General formatting --
        allow_bold = true,
        allow_italic = false,
        allow_underline = true,
        allow_undercurl = true,
        allow_reverse = true,
        highlights = {
          Search = { fg = "#000000", bg = "#FFCC00" },
          IncSearch = { fg = "#000000", bg = core.colors.yellow },
          Statusline = {
            bg = "#39260E",
            -- fg = c.purple, bg = c.bg
          },
        },
      })
      require("kimbox").load()
    end,
  },
  {
    "f-person/auto-dark-mode.nvim",
    enabled = is_enabled("auto-colorscheme"),
    config = {
      update_interval = 1000,
      set_dark_mode = function()
        require("no-clown-fiesta").setup({
          transparent = false, -- Enable this to disable the bg color
          styles = {
            -- You can set any of the style values specified for `:h nvim_set_hl`
            comments = {},
            keywords = {},
            functions = { bold = true },
            variables = {},
            type = { bold = true },
            lsp = { underline = true },
          },
        })
        vim.cmd([[colorscheme no-clown-fiesta]])
      end,
      set_light_mode = function()
        vim.api.nvim_set_option("background", "light")
        require("nebulous").setup({
          variant = "quasar"
        })
      end,
    },
    init = function()
      require("auto-dark-mode").init()
    end,
  },
  {
    "tjdevries/gruvbuddy.nvim",
    dependencies = {
      {
        "tjdevries/colorbuddy.nvim",
        branch = "dev"
      }
    },
    enabled = is_enabled('gruvbuddy'),
    lazy = false,
    init = function()
      require('colorbuddy').colorscheme('gruvbuddy')
      local Group = require("colorbuddy.group").Group
      local g = require("colorbuddy.group").groups
      local s = require("colorbuddy.style").styles

      Group.new("CmpItemAbbr", g.Comment)
      Group.new("CmpItemAbbrDeprecated", g.Error)
      Group.new("CmpItemAbbrMatchFuzzy", g.CmpItemAbbr.fg:dark(), nil, s.italic)
      Group.new("CmpItemKind", g.Special)
      Group.new("CmpItemMenu", g.NonText)

      -- Color.new("gray0", "#111111")
      -- Color.new("gray2", "#373b41")
      -- Color.new("gray1", "#282a2e")
      -- Color.new("gray3", "#969896")
      -- Color.new("gray4", "#b4b7b4")
      -- Color.new("gray5", "#c5c8c6")
      -- Color.new("gray6", "#e0e0e0")
      -- Color.new("gray7", "#ffffff")
    end
  },
  {
  "briones-gabriel/darcula-solid.nvim",
    dependencies = {
      "rktjmp/lush.nvim"
    },
    enabled = is_enabled('darcula'),
    lazy = false,
    config = function()
      vim.cmd 'colorscheme darcula-solid'
    end
  }
}
