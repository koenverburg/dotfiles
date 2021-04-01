require('plugins')
require('globals')

require('binds')

require('core.lsp')
require('core.treesitter')
require('core.statusline')

require('plugins.startup')
require('plugins.config')
require('plugins.tabline')
require('plugins.gitsigns')

-- TODO refactor this
require('finder.init')
require('finder.keybindings')
