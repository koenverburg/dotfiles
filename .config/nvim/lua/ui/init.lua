local scheme = require('ui.scheme')
scheme.kimbox()

local lines = require('ui.lines')
lines.tabline()
lines.lualine()
-- lines.statusline()
lines.winbar()

local highlight = require('ui.highlights')
highlight.setup()
highlight.fix()
highlight.hop()
