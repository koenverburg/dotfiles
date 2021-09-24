local ts_utils = require 'nvim-treesitter.ts_utils'

local ns = vim.api.nvim_create_namespace('ns')

local method_start_targets = {
  -- Lua
  'function',
  'function_name',
  'local_function',

  -- Go,
  'function_declaration',
}

local M = {}

local function setVirtualText(node)
  local targetLineNumber = node:start();

  local virtualText = " Helloo virtual text"

  vim.api.nvim_buf_set_virtual_text(0, ns, targetLineNumber, {{ virtualText, 'Comment' }}, {})
end

function M.show()
  local node = ts_utils.get_node_at_cursor()

  if not node then
    vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
    return
  end

  if vim.tbl_contains(method_start_targets, node:type()) then
    -- print(vim.inspect(ts_utils.get_named_children(node)))
    setVirtualText(node)
  end
end

return M
