local core = require('core.completion')
core.diagnostic()
core.cmp()
core.luasnip()

local lsp = require('core.lsp')
lsp.init()
-- lsp.nullLs()

require('core.treesitter')
