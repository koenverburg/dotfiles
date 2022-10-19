local utils = require('conrad.utils')
local nebulous = utils.loadable('nebulous')

local scheme = {
  none        = 'NONE',
  DarkRed     = "#FD2E6A",
  DarkOrange  = "#ff8d03",
  DarkBlue    = "#007ED3",
  DarkGreen   = "#5EB95D",
  DarkYellow  = "#FFCC00",
  DarkMagenta = "#FE92E1",
  DarkCyan    = "#56D6D6",
  DarkGrey    = "#555555",
  DarkGrey_2  = "#828989"
}

local red = {
  shade_1 = '#8b0000',
  shade_2 = '#7d0000',
  shade_3 = '#6f0000',
  shade_4 = '#610000',
  shade_5 = '#530000',
  shade_6 = '#460000',
  shade_7 = '#380000',
  shade_8 = '#2a0000',
  shade_9 = '#1c0000',
  shade_10 = '#0e0000',
}

nebulous.setup {
  variant = "night", -- night, twilight, midnight, fullmoon, quasar
  disable = {
    background = false,
    endOfBuffer = false,
    terminal_colors = false,
  },
  italic = {
    comments  = false,
    keywords  = false,
    functions = false,
    variables = false,
  },
  custom_colors = { -- this table can hold any group of colors with their respective values
    -- CursorLine        = { bg = red.shade_7 },
    -- Normal            = { bg = red.shade_10 },
    -- NormalNC          = { bg = red.shade_9 },
    TSCharacter       = {},
    TSConditional     = {},
    TSConstBuiltin    = {},
    TSConstMacro      = {},
    TSConstant        = { style = "bold" },
    TSConstructor     = {},
    TSError           = {},
    TSException       = {},
    TSField           = {},
    TSFloat           = {},
    TSFuncBuiltin     = {},
    TSFuncMacro       = {},
    TSFunction        = { style = "bold" },
    TSInclude         = {},
    TSKeyword         = { style = "bold" },
    TSLabel           = {},
    TSMethod          = { style = "bold" },
    TSNumber          = {},
    TSOperator        = { style = "bold" },
    TSParameter       = {},
    TSProperty        = {},
    TSPunctBracket    = {},
    TSString          = {},
    TSStringEscape    = {},
    TSStringRegex     = {},
    TSStructure       = {},
    TSType            = { style = "bold" },
    TSTypeBuiltin     = {},
    TSVariable        = {},
    TSVariableBuiltin = {},
    TSTagDelimiter    = {}, --style = "bold,italic" },

    -- Telescope
    TelescopeBorder =         { fg = scheme.Red,         bg = scheme.none, scheme.none },
    TelescopeMatching =       { fg = scheme.Yellow,      bg = scheme.none, scheme.none },
    TelescopeMultiSelection = { fg = scheme.LightGrey,   bg = scheme.none, scheme.none },
    TelescopeNormal =         { fg = scheme.White,       bg = scheme.none, scheme.none },
    TelescopePreviewBorder =  { fg = scheme.Red,         bg = scheme.none, scheme.none },
    TelescopePrompt =         { fg = scheme.White,       bg = scheme.none, scheme.none },
    TelescopePromptBorder =   { fg = scheme.Red,         bg = scheme.none, scheme.none },
    TelescopePromptPrefix =   { fg = scheme.White,       bg = scheme.none, scheme.none },
    TelescopeResultsBorder =  { fg = scheme.Red,         bg = scheme.none, scheme.none },
    TelescopeSelection =      { fg = scheme.White,       bg = scheme.Grey, style = "bold" },
    TelescopeSelectionCaret = { fg = scheme.Red,         bg = scheme.none, scheme.none },




    -- WinSeparator      = { fg = "NONE", background = 'NONE' }

    -- LineNr = { fg = "#5BBBDA", bg = "NONE", style = "NONE" },
    -- CursorLineNr = { fg = "#E1CD6C", bg = "NONE", style = "NONE" },

    -- it is possible to specify only the element to be changed
    -- TelescopePreviewBorder = { fg = "#A13413" },
    -- LspDiagnosticsDefaultError = { bg = "#E11313" },

    -- Treesitter colors
  }
}

-- local nc = utils.loadable('nightcoder')
-- if nc then
--   print('yes')
--   vim.cmd [[ colorscheme nightcoder ]]
--   return
-- end

-- require('ayu').setup({
--   mirage = true, -- Set to `true` to use `mirage` variant instead of `dark` for dark background.
-- })
-- vim.cmd [[ colorscheme ayu-dark ]]
-- vim.cmd [[ colorscheme darcula ]]
-- vim.cmd [[ colorscheme gruvbox ]]

-- vim.cmd [[ hi CursorLine gui=underline cterm=underline guibg=NONE ]]
-- vim.cmd [[ hi VertSplit guifg=#000000 ]] -- #2B2E35

-- local highlight = function(group, attr, sp)
--   attr = attr and "gui=" .. attr or "gui=NONE"
--   sp = sp and "guisp=" .. sp or ""
--
--   vim.api.nvim_command("highlight " .. group .. " ".. attr .. " " .. sp)
-- end

-- highlight("WinSeparator", "none")
-- highlight("VertSplit", "none")
--
-- vim.cmd [[ hi WinSeparator guifg=NONE ]] -- #2B2E35
-- vim.cmd [[ hi VertSplit guifg=NONE ]] -- #2B2E35

-- highlight('TSFunction', "bold")
-- highlight('TSBoolean',  "bold")
-- highlight('TSIdentifier',  "bold")
-- highlight('Identifier',  "bold")
-- highlight('TSVariable', "bold")

-- vim.cmd [[ hi TabLine guibg=NONE ]]
-- vim.cmd [[ hi TabLineSel guibg=NONE ]]
-- vim.cmd [[ hi TabLineFill guibg=NONE ]]
--
-- vim.cmd [[ hi GitSignsAdd guibg=NONE ]]
-- vim.cmd [[ hi GitSignsChange guibg=NONE ]]
-- vim.cmd [[ hi GitSignsDelete guibg=NONE ]]
-- vim.cmd [[ highlight NonText guibg=none ]]
-- vim.cmd [[ highlight Normal guibg=none ]]
