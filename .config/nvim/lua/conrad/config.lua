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
    label = "Close tab",
    callback = function()
      vim.cmd "tabclose"
    end,
  },
  {
    label = "exit",
    callback = function()
      -- vim.cmd "tabdo Workspace RightPanelToggle" -- if they are there
      vim.cmd ":SaveSession"
      vim.cmd ":qall"
    end,
  },

  {
    label = "ide",
    callback = function()
      vim.cmd "Workspace RightPanelToggle"
    end,
  },
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
vim.api.nvim_create_autocmd("TabNew", {
  pattern = "*",
  callback = function()
    vim.schedule(function()
      vim.cmd "Workspace RightPanelToggle"
      vim.cmd "Telescope git_files"
      -- vim.cmd(vim.api.nvim_replace_termcodes("", true, true, true))
    end)
  end,
})

-- vim.api.nvim_create_autocmd("", {
--   pattern = "*",
--   callback = function()
--     vim.schedule(function()
--       vim.cmd "Workspace RightPanelToggle"
--     end)
--   end,
-- })

-- vim.api.nvim_create_autocmd("WinEnter", {
--   pattern = "*",
--   callback = function()
--     vim.schedule(function()
--       vim.cmd "Workspace RightPanelToggle"
--     end)
--   end,
-- })

vim.api.nvim_create_autocmd("TabClosed", {
  pattern = "*",
  callback = function()
    for _, v in ipairs(vim.api.nvim_list_wins()) do
      local bufnr = vim.api.nvim_win_get_buf(v)
      local name = vim.fn.bufname(bufnr)

      if string.find(name, "component://*") then
        -- vim.api.nvim_buf_delete(bufnr, { force = true })
        vim.cmd "tabdo Workspace RightPanelToggle"
        return
      end
    end
  end
})

require("auto-session").setup {
  bypass_session_save_file_types = {
    "alpha",
    "NvimTree",
  },
  pre_save_cmds = {
    function()
      -- Close workspace when saving session
      vim.cmd "tabdo Workspace RightPanelToggle"
    end,
  },
  post_restore_cmds = {
    function()
      vim.schedule(function()
        -- vim.cmd "tabdo Workspace LeftPanelToggle"
        vim.cmd "tabdo Workspace RightPanelToggle"
        -- Open workspace when restoring session
        -- Equalize window after buffers are move due to workspace buffers
        -- vim.cmd(vim.api.nvim_replace_termcodes("normal <C-w>=", true, true, true))
      end)
    end,
  },
}

-- require("bookmarks").setup()
