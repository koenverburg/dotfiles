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
  ["typescriptreact"] = { " >", "=>", ">" },
  ["javascript"] = { " >", "=>", ">" },
  ["javascriptreact"] = { " >", "=>", ">" },
  ["markdown"] = { "_", "__", "_" },
  ["markdown"] = { "**", "****", "**" },
}

require('aerial').setup({
  open_automatic = true,
  close_behavior = "global",
  default_direction = "prefer_right",
  backends = { "lsp", "treesitter", "markdown" },
})

require('nvim-comment-frame').setup({
  disable_default_keymap = true,
  -- keymap = '<space>cc',
  -- multiline_keymap = '<space>C',
  frame_width = 70, -- width of the comment frame
  line_wrap_len = 50, -- wrap the line after 'n' characters
  auto_indent = true, -- automatically indent the comment frame based on the line
  add_comment_above = true, -- add comment above the current line
  languages = {
    javascript = {
      start_str = '//',
      end_str = '//',
      fill_char = '-'
    }
  }
})

require("conrad.plugins.charlist").setup {
  enabled = true,
}

require("minimal-tabline").setup({
  enable = true,
  file_name = true,
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

  -- shared
  "if_statement", -- go, js, ts

  -- JavaScript / TypeScript
  "arrow_function",
  "function_declaration",
  "generator_function_declaration",
})

