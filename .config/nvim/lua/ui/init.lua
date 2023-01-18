local scheme = require('ui.scheme')
-- scheme.toggle()
-- scheme.default()
scheme.zephyr()

local lines = require('ui.lines')
lines.tabline()
lines.statusline()
lines.winbar()

local highlight = require('ui.highlights')
highlight.setup()
highlight.fix()
