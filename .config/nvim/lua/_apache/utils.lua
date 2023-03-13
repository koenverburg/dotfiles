local ts_utils = require "nvim-treesitter.ts_utils"
local M = {}

function M.is_empty(v)
  return v == nil or v == ""
end

function M.P(value)
  print(vim.inspect(value))
  return value
end

function M.setVirtualText(ns, line, text, prefix)
  local virtualText = string.format(" %s", text)

  if not M.is_empty(prefix) then
    virtualText = string.format(" %s %s", prefix, text)
  end

  vim.api.nvim_buf_set_virtual_text(0, ns, line, { { virtualText, "Comment" } }, {})
end

function M.contains(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end

function M.dim(namespace, buffer, line_number)
  pcall(vim.api.nvim_buf_set_extmark, buffer, namespace, line_number, 0, {
    end_line = line_number + 1,
    end_col = 0,
    hl_group = "Comment", -- mvp
    hl_eol = true,
    priority = 10000,
  })
end

function M.loadable(name)
  local ok, module = pcall(require, name)

  if not ok then
    vim.notify("Failed to load " .. name)
    return
  end
  return module
end

function M.walk_tree(node, types)
  local expr = node

  while expr do
    if M.contains(types, expr:type()) then
      return expr
    end
    expr = expr:parent()
  end

  if not expr then
    return nil
  end
end

function M.walk_down(node, types)
  local expr = node
  local matches = {}

  while expr do
    if M.contains(types, expr:type()) then
      table.insert(matches, expr)
    end

    expr = expr:child()
  end

  if not expr then
    return nil
  end
end

function M.get_node(queries)
  local cursor_node = ts_utils.get_node_at_cursor()

  local node = M.walk_tree(cursor_node, queries)

  if node then
    return node
  end

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
