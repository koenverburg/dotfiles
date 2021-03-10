require('plugins')
require('globals')

require('binds')

require('core.lsp')
require('core.treesitter')
require('core.statusline')

require('plugins.startup')
require('plugins.config')
require('plugins.tabline')

-- TODO refactor this
require('finder.init')
require('finder.keybindings')

-- Disable baked in plugins
vim.g.loaded_gzip              = 0
vim.g.loaded_tar               = 0
vim.g.loaded_tarPlugin         = 0
vim.g.loaded_zip               = 0
vim.g.loaded_zipPlugin         = 0
vim.g.loaded_getscript         = 0
vim.g.loaded_getscriptPlugin   = 0
vim.g.loaded_vimball           = 0
vim.g.loaded_vimballPlugin     = 0
vim.g.loaded_matchit           = 0
vim.g.loaded_matchparen        = 0
vim.g.loaded_2html_plugin      = 0
vim.g.loaded_logiPat           = 0
vim.g.loaded_rrhelper          = 0
vim.g.loaded_netrw             = 0
vim.g.loaded_netrwPlugin       = 0
vim.g.loaded_netrwSettings     = 0
vim.g.loaded_netrwFileHandlers = 0
