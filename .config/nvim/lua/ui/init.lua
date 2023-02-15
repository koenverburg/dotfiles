local scheme = require('ui.scheme')
scheme.default()

local lines = require('ui.lines')
lines.tabline()
lines.statusline()
lines.winbar()

local highlight = require('ui.highlights')
highlight.setup()
highlight.fix()
highlight.hop()
