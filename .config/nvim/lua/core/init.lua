local core = require('core.completion')
core.diagnostic()
core.cmp()
core.luasnip()

local lsp = require('core.lsp')
lsp.init()
lsp.nullLs()
lsp.lines()

-- require('core.treesitter')
