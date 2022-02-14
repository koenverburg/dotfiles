local ts_utils = require('nvim-treesitter.ts_utils')

local function P(value)
  print(vim.inspect(value))
  return value
end

local M = {}
local api = vim.api

local ns = api.nvim_create_namespace('conrad/hints')

function M.setup_autocmd()
  api.nvim_command('augroup hints')
  api.nvim_command('autocmd BufEnter,BufWinEnter,TabEnter,BufWritePost *.ts,*.tsx,*.js,*.jsx :lua require"conrad.plugins.inlays".show()')
  api.nvim_command('augroup END')
end

local function setVirtualText(node, text)
  local targetLineNumber = node:start()
  local virtualText = " << " .. text
  api.nvim_buf_set_virtual_text(0, ns, targetLineNumber, {{ virtualText, 'Comment' }}, {})
end

function M.show()
  local node = ts_utils.get_node_at_cursor()

  if not node then
    vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
    return
  end

  P(node:type())

  -- setVirtualText(node, "hii")
end

return M
