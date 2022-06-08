local utils = require('conrad.utils')

require('ayu').setup({
  mirage = false, -- Set to `true` to use `mirage` variant instead of `dark` for dark background.
})

vim.cmd [[ colorscheme ayu-dark ]]

-- vim.cmd [[ colorscheme darcula ]]
-- require('colorbuddy').colorscheme('gruvbuddy')

local Color = require('colorbuddy').Color
local colors = require('colorbuddy').colors

local Group = require('colorbuddy').Group
local groups = require('colorbuddy').groups

local styles = require('colorbuddy').styles
Group.new("VertSplit", nil, nil, nil)
-- Group.new('TSBoolean', nil, nil, styles.bold)
-- Group.new('TSFunction', nil, nil, styles.bold)

--     TSCharacter       = {},
--     TSConditional     = {},
--     TSConstBuiltin    = {},
--     TSConstMacro      = {},
--     TSConstant        = {},
--     TSConstructor     = {},
--     TSError           = {},
--     TSException       = {},
--     TSField           = {},
--     TSFloat           = {},
--     TSFuncBuiltin     = {},
--     TSFuncMacro       = {},
--     TSInclude         = {},
--     TSKeyword         = {},
--     TSLabel           = {},
--     TSMethod          = {},
--     TSNumber          = {},
--     TSOperator        = {},
--     TSParameter       = {},
--     TSProperty        = {},
--     TSPunctBracket    = {},
--     TSString          = {},
--     TSStringEscape    = {},
--     TSStringRegex     = {},
--     TSStructure       = {},
--     TSTagDelimiter    = {},
--     TSType            = {},
--     TSTypeBuiltin     = {},
--     TSVariable        = {},
--     TSVariableBuiltin = {},
--     TSTagDelimiter    = {} --style = "bold,italic" },


-- local nebulous = utils.loadable('nebulous')
-- nebulous.setup {
--   variant = "night",
--   disable = {
--     background = false,
--     endOfBuffer = false,
--     terminal_colors = true,
--   },
--   italic = {
--     comments   = false,
--     keywords   = false,
--     functions  = false,
--     variables  = false,
--   },
--   custom_colors = { -- this table can hold any group of colors with their respective values
--     -- LineNr = { fg = "#5BBBDA", bg = "NONE", style = "NONE" },
--     -- CursorLineNr = { fg = "#E1CD6C", bg = "NONE", style = "NONE" },
--
--     -- it is possible to specify only the element to be changed
--     -- TelescopePreviewBorder = { fg = "#A13413" },
--     -- LspDiagnosticsDefaultError = { bg = "#E11313" },
--
--     -- Treesitter colors
--   }
-- }
