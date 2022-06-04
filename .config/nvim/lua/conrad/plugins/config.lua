require("fidget").setup()
require("nvim-tree").setup()
require("session-lens").setup()

require("Comment").setup() -- The bindings need to updated from this plugin

-- vim.notify = require "notify"

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

require("minimal-tabline").setup({
  enable = true,
  file_name = false,
  tab_index = true,
  pane_count = true,
  modified_sign = true,
  no_name = '[No Name]'
})

require('cmd-palette').setup({
  { label = "Peepsight", cmd = "Peepsight" },
  { label = "quite", callback = function()
    vim.cmd [[ set nonumber ]]
    vim.o.signcolumn = "no"
    end
  },
  { label = "reset", callback = function()
    vim.cmd [[ set number ]]
    vim.o.signcolumn = "yes"
    end
  },
})

require('peepsight').setup({
  -- go
  "function_declaration",
  "method_declaration",
  "func_literal",

  -- JavaScript / TypeScript
  "if_statement",
  "arrow_function",
  "function_declaration",
  "generator_function_declaration",
})
