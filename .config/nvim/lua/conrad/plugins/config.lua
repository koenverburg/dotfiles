require('dim').setup()
require("Comment").setup()
require("session-lens").setup()
require('colorizer').setup()
require("lsp_lines").setup()

local npairs = require "nvim-autopairs"
local Rule = require "nvim-autopairs.rule"
npairs.setup()
npairs.add_rule(Rule("<", ">"))

require("smartinput").setup {
  ["go"]              = { ";", ":=", ";" },
  ["typescript"]      = { " >", "=>", ">" },
  ["javascript"]      = { " >", "=>", ">" },
  ["typescriptreact"] = { " >", "=>", ">" },
  ["javascriptreact"] = { " >", "=>", ">" },
}

require("fidget").setup {
  text = {
    spinner = "dots_snake"
  }
}

require("indent_blankline").setup {
  show_current_context = false,
  show_current_context_start = false,
}

require("nvim-comment-frame").setup {
  disable_default_keymap = true,
  -- keymap = '<space>cc',
  -- multiline_keymap = '<space>C',
  frame_width = 70, -- width of the comment frame
  line_wrap_len = 50, -- wrap the line after 'n' characters
  auto_indent = true, -- automatically indent the comment frame based on the line
  add_comment_above = true, -- add comment above the current line
  languages = {
    javascript = {
      start_str = "//",
      end_str = "//",
      fill_char = "-",
    },
  },
}

require("conrad.plugins.charlist").setup {
  enabled = true,
  -- defaults = {
  --   precedes = "…",
  --   eol = " ",
  --   tab = "  ",
  --   trail = " ",
  --   space = " ",
  --   nbsp = "☠",
  --   extends = "#",
  --   conceal = "┊",
  -- },
}

require("minimal-tabline").setup {
  enable = true,
  file_name = false,
  tab_index = true,
  pane_count = false,
  modified_sign = true,
  no_name = "[No Name]",
}

require("cmd-palette").setup {
  { label = "Peepsight", cmd = "Peepsight" },
  {
    label = "quite",
    callback = function()
      vim.cmd [[ set nonumber ]]
      vim.o.signcolumn = "no"
    end,
  },
  {
    label = "reset",
    callback = function()
      vim.cmd [[ set number ]]
      vim.o.signcolumn = "yes"
    end,
  },
  {
    label = "conceal",
    callback = function()
      if vim.o.conceallevel > 0 then
        vim.o.conceallevel = 0
      else
        vim.o.conceallevel = 2
      end
    end,
  },
}

require("peepsight").setup {
  -- go
  "function_declaration",
  "method_declaration",
  "func_literal",

  -- shared
  -- "if_statement", -- go, js, ts

  -- JavaScript / TypeScript
  "arrow_function",
  "function_declaration",
  "generator_function_declaration",
}

require("mason").setup()
require("mason-lspconfig").setup {
  ensure_installed = {
    "gopls",
    "cssls",
    "tsserver",
    "dockerls",
    "sumneko_lua",
    "tailwindcss",
  },
}

require("inlay-hints").setup({
  only_current_line = true,

  eol = {
    right_align = true,
  }
})

-- vim.api.nvim_create_autocmd("FileType", {
--   pattern= "*",
--   callback = function ()
--     local bufnr = vim.api.nvim_get_current_buf()
--     local ft = vim.api.nvim_buf_get_option(bufnr, "filetype")
--
--     if (ft == 'typescript') then
--       require('conrad.experiments.conceal').typescript()
--     end
--
--   end
-- })

-- require("illuminate").configure {
--   -- delay = 100,
--   providers = {
--     "lsp",
--     "treesitter",
--     "regex",
--   },
--   filetype_overrides = {},
--   filetypes_denylist = {
--     "dirvish",
--     "fugitive",
--   },
--   filetypes_allowlist = {},
--   modes_denylist = {},
--   modes_allowlist = {},
--   providers_regex_syntax_denylist = {},
--   providers_regex_syntax_allowlist = {},
--   under_cursor = true,
-- }
-- vim.cmd [[ hi def IlluminatedWordText gui=underline ]]
