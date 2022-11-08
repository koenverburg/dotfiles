-- My Vimrc
-- Author: Koen Verburg <creativekoen@gmail.com>
-- Source: https://github.com/koenverburg/dotfiles

local u = require('conrad.utils')
u.loadable("impatient")
u.loadable("packer_compiled")

require("conrad.disable_builtin")
require("conrad.__bootstrap")
require("conrad.packer")

require('core')

require("conrad.globals")
require("conrad.binds")

require("conrad.telescope")
require("conrad.lsp")

require("conrad.core.treesitter")
require("conrad.plugins.config")

