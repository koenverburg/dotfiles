local utils = require "conrad.utils"

local ts_utils = require "nvim-treesitter.ts_utils"

local M = {}

function M.walk_tree(node, types)
  local expr = node

  while expr do
    if utils.contains(types, expr:type()) then
      return expr
    end
    expr = expr:parent()
  end

  if not expr then return nil end
end


function M.get_node(queries)
  local cursor_node = ts_utils.get_node_at_cursor()

  local node = M.walk_tree(cursor_node, queries)

  if node then return node end

  return nil
end

function M.get_query_matches(bufnr, query)
  local tree = vim.treesitter.get_parser(bufnr)

  if not tree then
    return nil
  end

  local ast = tree:parse()
  local root = ast[1]:root()

  local parsed = vim.treesitter.parse_query(tree:lang(), query)
  local results = parsed:iter_matches(root, bufnr)

  return results
end

return M
