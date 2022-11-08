-- My Vimrc
-- Author: Koen Verburg <creativekoen@gmail.com>
-- Source: https://github.com/koenverburg/dotfiles

local u = require('utils')
u.loadable("impatient")
u.loadable("packer_compiled")

require("bootstrap")
require("bootstrap.packer")

require('options')
require("keybinds")

require("conrad.config")

require('core')
require('ui')
require('search')

