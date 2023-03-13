is_enabled = require('_apache.functions').is_enabled

return {
  {
    "Yagua/nebulous.nvim",
    enabled = is_enabled('nebulous'),
    lazy = false,

    config = function ()
      require('nebulous').setup({
        variant = "night"
      })
    end,
  },
  {
    "lmburns/kimbox",
    enabled = is_enabled('kimbox'),
    lazy = false,

    config = function ()
      require("kimbox").setup {
        style = "light", -- choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'

        -- General formatting --
        allow_bold = true,
        allow_italic = false,
        allow_underline = true,
        allow_undercurl = true,
        allow_reverse = true,

        highlights = {
          Search = { fg = "#000000", bg = "#FFCC00" },
          IncSearch = { fg = "#000000", bg = c.colors.light_red },

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
