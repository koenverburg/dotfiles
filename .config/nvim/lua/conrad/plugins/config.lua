require("fidget").setup()
require("nvim-tree").setup()
require("session-lens").setup()
require("minimal-tabline").setup()

require("Comment").setup() -- The bindings need to updated from this plugin

vim.notify = require "notify"

require("nvim-autopairs").setup()
local Rule = require "nvim-autopairs.rule"
local npairs = require "nvim-autopairs"
npairs.add_rule(Rule("<", ">"))

require("smartinput").setup {
  ["go"] = { ";", ":=", ";" },
  ["typescript"] = { " >", "=>", ">" },
  ["markdown"] = { "_", "__", "_" },
  ["markdown"] = { "**", "****", "**" },
}

require("conrad.plugins.charlist").setup {
  enabled = true,
}

-- require('shade').setup({
--   overlay_opacity = 50,
--   opacity_step = 1,
--   keys = {
--     brightness_up    = '<C-Up>',
--     brightness_down  = '<C-Down>',
--     toggle           = '<Leader>s',
--   }
-- })
