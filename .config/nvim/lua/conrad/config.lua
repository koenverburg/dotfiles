require('dim').setup()
require("session-lens").setup()
require('colorizer').setup()


-- require("smartinput").setup {
--   ["go"]              = { ";", ":=", ";" },
--   ["typescript"]      = { " >", "=>", ">" },
--   ["javascript"]      = { " >", "=>", ">" },
--   ["typescriptreact"] = { " >", "=>", ">" },
--   ["javascriptreact"] = { " >", "=>", ">" },
-- }

require("Comment").setup()
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

require("indent_blankline").setup {
  show_current_context = false,
  show_current_context_start = false,
}

require("conrad.charlist").setup {
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

local temp = require('template')

temp.temp_dir = '~/.config/nvim/template'
temp.author = 'Koen Verburg (Conrad The Programmer)'
temp.email = ''

-- require('coman')

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
  {
    label = "Edit in new tab",
    callback = function()
      vim.cmd(":tabedit %|tabprev|:q")
    end,
  },
  {
    label = "view diff <> master",
    callback = function()
      vim.cmd(":Easypick changed_files_api")
    end,
  },
  {
    label = "view diff <> main",
    callback = function()
      vim.cmd(":Easypick changed_files_exp")
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

-- vim.api.nvim_create_autocmd("FileType", {
--   pattern= "*",
--   callback = function ()
--     local bufnr = vim.api.nvim_get_current_buf()
--     local ft = vim.api.nvim_buf_get_option(bufnr, "filetype")
--
--     if (ft == 'typescript') then
--       require('experiments.conceal').typescript()
--     end
--
--   end
-- })
require('illuminate').configure({
  providers = {
    'lsp',
    'treesitter',
    'regex',
  },
  -- filetype_overrides: filetype specific overrides.
  -- The keys are strings to represent the filetype while the values are tables that
  -- supports the same keys passed to .configure except for filetypes_denylist and filetypes_allowlist
  filetype_overrides = {},
  -- filetypes_denylist: filetypes to not illuminate, this overrides filetypes_allowlist
  filetypes_denylist = {
      'dirvish',
      'fugitive',
  },
  filetypes_allowlist = {},
})
