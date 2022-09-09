local utils = require('conrad.utils')

-- require('ayu').setup({
--   mirage = true, -- Set to `true` to use `mirage` variant instead of `dark` for dark background.
-- })
-- vim.cmd [[ colorscheme ayu-dark ]]
-- vim.cmd [[ colorscheme darcula ]]

-- local palette = require('gruvbox.palette')
-- require('gruvbox').setup({
--   italic = false,
--   contrast = "hard",
--   overrides = {
--     SignColumn = { bg = palette.dark0_hard }
--   }
-- })
--
-- vim.cmd [[ colorscheme gruvbox ]]

vim.cmd [[ hi TabLine guibg=NONE ]]
vim.cmd [[ hi TabLineSel guibg=NONE ]]
vim.cmd [[ hi TabLineFill guibg=NONE ]]

vim.cmd [[ hi GitSignsAdd guibg=NONE ]]
vim.cmd [[ hi GitSignsChange guibg=NONE ]]
vim.cmd [[ hi GitSignsDelete guibg=NONE ]]



local nebulous = utils.loadable('nebulous')
nebulous.setup {
  variant = "fullmoon", -- night, twilight, midnight, fullmoon, quasar
  disable = {
    background = false,
    endOfBuffer = false,
    terminal_colors = true,
  },
  italic = {
    comments   = false,
    keywords   = false,
    functions  = false,
    variables  = false,
  },
  custom_colors = { -- this table can hold any group of colors with their respective values
    TSCharacter       = {},
    TSConditional     = {},
    TSConstBuiltin    = {},
    TSConstMacro      = {},
    TSConstant        = {style = "bold"},
    TSConstructor     = {},
    TSError           = {},
    TSException       = {},
    TSField           = {},
    TSFloat           = {},
    TSFuncBuiltin     = {},
    TSFuncMacro       = {},
    TSFunction        = {style = "bold"},
    TSInclude         = {},
    TSKeyword         = {style = "bold"},
    TSLabel           = {},
    TSMethod          = {style = "bold"},
    TSNumber          = {},
    TSOperator        = {style = "bold"},
    TSParameter       = {},
    TSProperty        = {},
    TSPunctBracket    = {},
    TSString          = {},
    TSStringEscape    = {},
    TSStringRegex     = {},
    TSStructure       = {},
    TSType            = {style = "bold"},
    TSTypeBuiltin     = {},
    TSVariable        = {},
    TSVariableBuiltin = {},
    TSTagDelimiter    = {}, --style = "bold,italic" },

    -- LineNr = { fg = "#5BBBDA", bg = "NONE", style = "NONE" },
    -- CursorLineNr = { fg = "#E1CD6C", bg = "NONE", style = "NONE" },

    -- it is possible to specify only the element to be changed
    -- TelescopePreviewBorder = { fg = "#A13413" },
    -- LspDiagnosticsDefaultError = { bg = "#E11313" },

    -- Treesitter colors
  }
}


-- vim.cmd [[ hi CursorLine gui=underline cterm=underline guibg=NONE ]]
-- vim.cmd [[ hi VertSplit guifg=#000000 ]] -- #2B2E35

local highlight = function(group, attr, sp)
  attr = attr and "gui=" .. attr or "gui=NONE"
  sp = sp and "guisp=" .. sp or ""

  vim.api.nvim_command("highlight " .. group .. " ".. attr .. " " .. sp)
end

highlight("WinSeparator", "none")
highlight("VertSplit", "none")

-- highlight('TSFunction', "bold")
-- highlight('TSBoolean',  "bold")
-- highlight('TSIdentifier',  "bold")
-- highlight('Identifier',  "bold")
-- highlight('TSVariable', "bold")

-- vim.cmd [[ highlight NonText guibg=none ]]
-- vim.cmd [[ highlight Normal guibg=none ]]
