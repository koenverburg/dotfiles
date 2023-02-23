local core = require('core.completion')
core.diagnostic()
core.cmp()
core.luasnip()

local lsp = require('core.lsp')
lsp.init()
lsp.nullLs()
lsp.lines()

-- local ide = require('core.ide')
-- ide.setup()

require('core.treesitter')
