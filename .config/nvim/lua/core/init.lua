local core = require('core.completion')
core.diagnostic()
core.luasnip()
core.cmp()

local lsp = require('core.lsp')
lsp.init()
lsp.nullLs()
lsp.lines()

-- require('core.treesitter')
