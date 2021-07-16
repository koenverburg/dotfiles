-- require('planery.reload').reload_module('popup')

-- local popup = require('popup')

-- popup.create('Hello World', {
--   results = {
--     minheight = 10,
--     minwidth = 0.8
--   },
--   line = 8,
--   col = 55,
--   -- padding = { 0, 0, 0, 0 },
--   borderchars = {"─", "│", "─", "│", "┌", "┐", "┘", "└"},
--   -- borderchars = {"━", "┃", "━", "┃", "┏", "┓", "┛", "┗"}
--   -- borderchars = {"═", "║", "═", "║", "╔", "╗", "╝", "╚"}
-- })



local plenary_window = require('plenary.window.float').percentage_range_window(0.5, 0.2)
vim.api.nvim_buf_set_option(plenary_window.bufnr, 'buftype', 'prompt')

vim.fn.prompt_setprompt(plenary_window.bufnr, 'scope:')

vim.fn.prompt_setcallback(plenary_window.bufnr, function(text)
  vim.api.nvim_win_close(plenary_window.win_id, true)
  print(text)

  -- if text ~= "" then
  --   vim.schedule(function()
  --     vim.api.nvim_buf_delete(plenary_window.bufnr, { force = true })

  --     vim.lsp.buf.rename(text)
  --   end)
  -- else
  --   print "Nothing to rename!"
  -- end
end)

vim.cmd [[ startinsert ]]
