local scheme = {}
local utils = require('utils')
scheme.toggle = function()
  local nightcoder = utils.loadable('nightcoder')
  if nightcoder then
    scheme.nightcoder()
  else
    scheme.default()
  end
end

scheme.kimbox = function ()
  require("kimbox").setup({
    style = "dark", -- choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
  })
  require("kimbox").load()
end


scheme.nightcoder = function ()
  vim.cmd [[ colorscheme nightcoder ]]
end

scheme.github = function ()
  vim.cmd [[ colorscheme github_dark_default ]]
end

scheme.gruvbox = function ()
  vim.cmd [[ colorscheme gruvbox ]]
end

scheme.zephyr = function ()
  vim.cmd [[ colorscheme zephyr ]]
end

-- local base_scheme = {
--   none        = 'NONE',
--   DarkRed     = "#FD2E6A",
--   DarkOrange  = "#ff8d03",
--   DarkBlue    = "#007ED3",
--   DarkGreen   = "#5EB95D",
--   DarkYellow  = "#FFCC00",
--   DarkMagenta = "#FE92E1",
--   DarkCyan    = "#56D6D6",
--   DarkGrey    = "#555555",
--   DarkGrey_2  = "#828989"
-- }

-- local red = {
--   shade_1 = '#8b0000',
--   shade_2 = '#7d0000',
--   shade_3 = '#6f0000',
--   shade_4 = '#610000',
--   shade_5 = '#530000',
--   shade_6 = '#460000',
--   shade_7 = '#380000',
--   shade_8 = '#2a0000',
--   shade_9 = '#1c0000',
--   shade_10 = '#0e0000',
-- }


scheme.default = function()
  local nebulous = utils.loadable('nebulous')

  if nebulous == nil then
    print("couldnt load nebulous")
    return
  end
  local colors = require("nebulous.functions").get_colors("nova")

  nebulous.setup {
    variant = "night", -- night, nova, twilight, midnight, fullmoon, quasar
    disable = {
      background = false,
      endOfBuffer = false,
      terminal_colors = true,
    },
    italic = {
      comments  = false,
      keywords  = false,
      functions = false,
      variables = false,
    },
    custom_colors = {
      -- LineNr =       { fg = colors.Blue,   bg = colors.none, style = colors.none },
      -- CursorLineNr = { fg = colors.Yellow, bg = colors.none, style = colors.none },

      -- TelescopeResultsBorder = { fg = colors.DarkGrey_2, bg = colors.none, style = colors.none },
      -- TelescopePreviewBorder = { fg = colors.DarkGrey_2, bg = colors.none, style = colors.none },
      -- TelescopePromptBorder =  { fg = colors.DarkGrey_2, bg = colors.none, style = colors.none },
      -- TelescopeBorder =        { fg = colors.DarkGrey_2, bg = colors.none, style = colors.none },

      -- highlight groups for custom status line
      -- StatusLineWarn = { fg = colors.DarkOrange, bg = colors.Grey, colors.none },
      -- StatusLineModes = { fg = colors.Aqua, bg = colors.none, colors.none },

      --Fidget
      FidgetTitle = { fg = colors.DarkOrange, bg = colors.none, style = colors.none },
      -- CursorLine        = { bg = red.shade_7 },
      -- Normal            = { bg = red.shade_10 },
      -- NormalNC          = { bg = red.shade_9 },
      -- TSCharacter       = {},
      -- TSConditional     = {},
      -- TSConstBuiltin    = {},
      -- TSConstMacro      = {},
      -- TSConstant        = { style = "bold" },
      -- TSConstructor     = {},
      -- TSError           = {},
      -- TSException       = {},
      -- TSField           = {},
      -- TSFloat           = {},
      -- TSFuncBuiltin     = {},
      -- TSFuncMacro       = {},
      -- TSFunction        = { style = "bold" },
      -- TSInclude         = {},
      -- TSKeyword         = { style = "bold" },
      -- TSLabel           = {},
      -- TSMethod          = { style = "bold" },
      -- TSNumber          = {},
      -- TSOperator        = { style = "bold" },
      -- TSParameter       = {},
      -- TSProperty        = {},
      -- TSPunctBracket    = {},
      -- TSString          = {},
      -- TSStringEscape    = {},
      -- TSStringRegex     = {},
      -- TSStructure       = {},
      -- TSType            = { style = "bold" },
      -- TSTypeBuiltin     = {},
      -- TSVariable        = {},
      -- TSVariableBuiltin = {},
      -- TSTagDelimiter    = {}, --style = "bold,italic" },

      -- Telescope
      -- TelescopeBorder =         { fg = base_scheme.Red,         bg = base_scheme.none, base_scheme.none },
      -- TelescopeMatching =       { fg = base_scheme.Yellow,      bg = base_scheme.none, base_scheme.none },
      -- TelescopeMultiSelection = { fg = base_scheme.LightGrey,   bg = base_scheme.none, base_scheme.none },
      -- TelescopeNormal =         { fg = base_scheme.White,       bg = base_scheme.none, base_scheme.none },
      -- TelescopePreviewBorder =  { fg = base_scheme.Red,         bg = base_scheme.none, base_scheme.none },
      -- TelescopePrompt =         { fg = base_scheme.White,       bg = base_scheme.none, base_scheme.none },
      -- TelescopePromptBorder =   { fg = base_scheme.Red,         bg = base_scheme.none, base_scheme.none },
      -- TelescopePromptPrefix =   { fg = base_scheme.White,       bg = base_scheme.none, base_scheme.none },
      -- TelescopeResultsBorder =  { fg = base_scheme.Red,         bg = base_scheme.none, base_scheme.none },
      -- TelescopeSelection =      { fg = base_scheme.White,       bg = base_scheme.Grey, style = "bold" },
      -- TelescopeSelectionCaret = { fg = base_scheme.Red,         bg = base_scheme.none, base_scheme.none },

      -- WinSeparator      = { fg = "NONE", background = 'NONE' }

      -- LineNr = { fg = "#5BBBDA", bg = "NONE", style = "NONE" },
      -- CursorLineNr = { fg = "#E1CD6C", bg = "NONE", style = "NONE" },

      -- it is possible to specify only the element to be changed
      -- TelescopePreviewBorder = { fg = "#A13413" },
      -- LspDiagnosticsDefaultError = { bg = "#E11313" },

      -- Treesitter colors
    }
  }
end

return scheme
