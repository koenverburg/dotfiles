-- My Vimrc
-- Author: Koen Verburg <creativekoen@gmail.com>
-- Source: https://github.com/koenverburg/dotfiles

vim.g.mapleader = ","
require("_apache.bootstrap")
require("_apache.lazy")
require("_apache.options")
require("_apache.keymaps")
require("_apache.autocmds")

require("_apache.functions").hideTablineWhenSingleTab()

require("conrad.winbar")
require("conrad.charlist").setup({
  enabled = false,
  defaults = {
    eol = "↲",
    tab = "» ",
    trail = "·",
    space = "·",
    nbsp = "☠",
    -- nbsp = '␣',
    extends = "#",
    precedes = "…",
    conceal = "┊",
  },
})
