local scheme = require('ui.scheme')
scheme.toggle()

local lines = require('ui.lines')
lines.tabline()
lines.statusline()
lines.winbar()

local highlight = require('ui.highlights')
highlight.setup()
