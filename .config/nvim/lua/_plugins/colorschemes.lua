is_enabled = require('_apache.functions').is_enabled
local core = require('_apache.core')

return {
  {
    "Yagua/nebulous.nvim",
    enabled = is_enabled('nebulous'),
    lazy = false,
    opts = {
      variant = "midnight"
    },
    config = function (_, opts)
      require('nebulous').setup(opts)
    end,
  },
  {
    "lmburns/kimbox",
    enabled = is_enabled('kimbox'),
    lazy = false,

    config = function ()
      require("kimbox").setup {
        style = "dark", -- choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'

        -- General formatting --
        allow_bold = true,
        allow_italic = false,
        allow_underline = true,
        allow_undercurl = true,
        allow_reverse = true,

        highlights = {
          Search = { fg = "#000000", bg = "#FFCC00" },
          IncSearch = { fg = "#000000", bg = core.colors.yellow},

          Statusline = {
            bg = "#39260E",
            -- fg = c.purple, bg = c.bg
          },
        },
      }
      require("kimbox").load()
    end,
  }
}
