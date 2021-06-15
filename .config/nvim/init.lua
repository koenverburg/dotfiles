-- My Vimrc
-- Author: Koen Verburg <creativekoen@gmail.com>
-- Source: https://github.com/koenverburg/dotfiles
require('conrad.plugins')
require('conrad.globals')
require('conrad.binds')

require('conrad.telescope')
require('conrad.servers')

require('conrad.core.treesitter')
require('conrad.core.statusline')

require('conrad.plugins.startup')
require('conrad.plugins.config')
require('conrad.plugins.tabline')
require('conrad.plugins.gitsigns')
require('conrad.plugins.formatting')

