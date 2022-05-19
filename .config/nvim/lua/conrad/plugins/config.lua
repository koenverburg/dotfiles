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

require('cmd-palette').setup({
  { label = "PeepsightToggle", cmd = "Peepsight" },
  -- { label = "Greeting", callback = function() print("Hello, Koen") end },
})

require('peepsight').setup(nil, {
  -- go
  "function_declaration",
  "method_declaration",
  "func_literal",

  -- JavaScript / TypeScript
  "arrow_function",
  "function_declaration",
  "generator_function_declaration",
})
