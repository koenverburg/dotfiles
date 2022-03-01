-- My Vimrc
-- Author: Koen Verburg <creativekoen@gmail.com>
-- Source: https://github.com/koenverburg/dotfiles

require("impatient")
require("packer_compiled")

require("conrad.disable_builtin")

require("conrad.bootstrap")
require("conrad.packer")

require("conrad.globals")
require("conrad.binds")

require("conrad.telescope")
require("conrad.lsp")

require("conrad.core.treesitter")

-- Move all of these to after/plugin
require("conrad.plugins.config")
require("conrad.plugins.gitsigns")
require("conrad.plugins.formatting")
