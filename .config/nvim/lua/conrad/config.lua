require("dim").setup()
require("colorizer").setup()
require("smoothcursor").setup {
  autostart = true,
  cursor = "", -- cursor shape (need nerd font)
  texthl = "SmoothCursor", -- highlight group, default is { bg = nil, fg = "#FFD400" }
  linehl = nil, -- highlight sub-cursor line like 'cursorline', "CursorLine" recommended
  type = "default", -- define cursor movement calculate function, "default" or "exp" (exponential).
  fancy = {
    enable = true, -- enable fancy mode
    head = { cursor = "", texthl = "SmoothCursor", linehl = nil },
    body = {
      { cursor = "", texthl = "SmoothCursorRed" },
      { cursor = "", texthl = "SmoothCursorOrange" },
      { cursor = "●", texthl = "SmoothCursorYellow" },
      { cursor = "●", texthl = "SmoothCursorGreen" },
      { cursor = "•", texthl = "SmoothCursorAqua" },
      { cursor = ".", texthl = "SmoothCursorBlue" },
      { cursor = ".", texthl = "SmoothCursorPurple" },
    },
    tail = { cursor = nil, texthl = "SmoothCursor" },
  },
  flyin_effect = nil, -- "bottom" or "top"
  speed = 25, -- max is 100 to stick to your current position
  intervals = 35, -- tick interval
  priority = 10, -- set marker priority
  timeout = 3000, -- timout for animation
  threshold = 3, -- animate if threshold lines jump
  disable_float_win = false, -- disable on float window
  enabled_filetypes = nil, -- example: { "lua", "vim" }
  disabled_filetypes = nil, -- this option will be skipped if enabled_filetypes is set. example: { "TelescopePrompt", "NvimTree" }
}
require("autoclose").setup {
  ["<"] = { escape = true, close = true, pair = "<>" },
}

require("hop").setup()
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
  show_current_context = true,
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

local temp = require "template"

temp.temp_dir = "~/.config/nvim/template"
temp.author = "Koen Verburg (Conrad The Programmer)"
temp.email = ""

-- require('coman')

require("cmd-palette").setup {
  { label = "Peepsight", cmd = "Peepsight" },
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
      vim.cmd ":tabedit %|tabprev|:q"
    end,
  },
  {
    label = "view diff <> master",
    callback = function()
      vim.cmd ":Easypick changed_files_api"
    end,
  },
  {
    label = "view diff <> main",
    callback = function()
      vim.cmd ":Easypick changed_files_exp"
    end,
  },
}

-- require("styler").setup({
--   themes = {
--     markdown = { colorscheme = "solarized", background = "light" },
--     -- help = { colorscheme = "catppuccin-mocha", background = "dark" },
--   },
-- })

-- require("no-neck-pain").setup()

require("peepsight").setup {
  -- markdown
  "paragraph",

  -- go
  "function_declaration",
  "method_declaration",
  "func_literal",

  -- shared
  -- "if_statement", -- go, js, ts

  -- JavaScript / TypeScript
  "class_declaration",
  "method_definition",
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

-- Open Workspace on new tab creation
-- vim.api.nvim_create_autocmd("TabNew", {
--   pattern = "*",
--   callback = function()
--     vim.schedule(function()
--       vim.cmd "Telescope git_files"
--     end)
--   end,
-- })
require("accelerated-jk").setup {
  mode = "time_driven",
  enable_deceleration = true,
  acceleration_motions = {},
  acceleration_limit = 150,
  acceleration_table = { 2, 7, 26, 28, 30 },
  -- acceleration_table = { 2, 7, 12, 17, 21, 24, 26, 28, 30 },
  -- when 'enable_deceleration = true',
  deceleration_table = { {200, 3}, {300, 7}, {450, 11}, {600, 15}, {750, 21}, {900, 9999} }
  -- deceleration_table = { { 150, 9999 } },
}

require("auto-session").setup {
  bypass_session_save_file_types = {
    "alpha",
    "NvimTree",
  },
}
