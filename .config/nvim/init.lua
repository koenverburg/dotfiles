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

local quite_list = {
  eol = " ",
  tab = "  ",
  trail = " ",
  space = " ",
  nbsp = "☠",
  extends = "#",
  precedes = "…",
  conceal = "┊",
}

local default_list = {
  eol = "↲",
  tab = "» ",
  trail = "•",
  space = "·",
  nbsp = "☠",
  -- nbsp = '␣',
  extends = "#",
  precedes = "…",
  conceal = "┊",

  -- Defaults
  vert = "|", -- alternatives │
  fold = " ",
  eob = "~", -- suppress ~ at EndOfBuffer
  diff = "─", -- alternatives: ⣿ ░
  msgsep = "‾",
  foldopen = "▾",
  foldsep = "│",
  foldclose = "▸",
}

-- require('conrad.plugins.charlist').setup({
--   enabled = true,
--   defaults = default_list
-- })
