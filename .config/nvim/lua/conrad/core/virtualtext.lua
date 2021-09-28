local ts_utils = require 'nvim-treesitter.ts_utils'
local ns = vim.api.nvim_create_namespace('ns')
local M = {}

local method_start_targets = {
  -- Lua
  'function',
  'function_name',
  'local_function',

  -- Go,
  'function_declaration',
}

local function P(value)
  print(vim.inspect(value))
end

-- local Helpers = {}

-- function Helpers.DetermineIfStatementScore(node)
--   print('hii from helpers')
-- end

local score_table = {
  return_statement = 1,
  if_statement = 1, -- Helpers.DetermineIfStatementScore(node),
}

local function calculateScore(node)
  local result = 0
  local node_type = node:type()

  if not vim.tbl_contains(vim.tbl_keys(score_table), node_type) then
    print("not in dict")
    return
  end

  if type(score_table[node_type] == 'function') then
    result = result + tonumber(score_table[node_type])
  else
    result = result + tonumber(score_table[node_type])
  end

  print(result)

  return result
end


local function loopOverChildren(node)
  local m = 0
  local child_nodes = ts_utils.get_named_children(node)
  if not child_nodes then return end

  for _, key in ipairs(child_nodes) do
    if key:type() == 'block' then
      for _, j in ipairs(ts_utils.get_named_children(key)) do
        m = m + tonumber(calculateScore(j))
      end
    else
      print("found " .. key:type())
    end
  end

  return m
end

local function setVirtualText(node, score)
  local targetLineNumber = node:start();
  local virtualText = " CC: " .. score
  vim.api.nvim_buf_set_virtual_text(0, ns, targetLineNumber, {{ virtualText, 'Comment' }}, {})
end

function M.show()
  local node = ts_utils.get_node_at_cursor()

  if not node then
    vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
    return
  end

  if vim.tbl_contains(method_start_targets, node:type()) then
    local score = loopOverChildren(node)
    setVirtualText(node, score)
  end
end

return M
