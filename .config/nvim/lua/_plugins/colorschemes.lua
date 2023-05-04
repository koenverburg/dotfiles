local is_enabled = require("_apache.functions").is_enabled
local core = require("_apache.core")

return {
  {
    "Yagua/nebulous.nvim",
    enabled = is_enabled("nebulous"),
    lazy = false,
    opts = {
      variant = "night",
    },
    config = function(_, opts)
      require("nebulous").setup(opts)
    end,
  },
  {
    "aktersnurra/no-clown-fiesta.nvim",
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
      require("no-clown-fiesta").setup(opts)
      vim.cmd[[colorscheme no-clown-fiesta]]
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
}
