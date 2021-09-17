local parsers = require('nvim-treesitter.parsers')
local ts_utils = require('nvim-treesitter.ts_utils')

local M = {}

function M.get_root(bufnr, filetype)
    local parser = parsers.get_parser(bufnr or 0, filetype)
    return parser:parse()[1]:root()
end

function M.createQuery(bufnr, filetype, query)
  return setmetatable({
    query = query,
    bufnr = bufnr,
    root = M.get_root(bufnr, filetype),
    filetype = filetype,
  }, self)
end

function M.foo()
  local bufnr = vim.fn.bufnr()
  local filetype = vim.bo[bufnr].filetype

  -- local parser = M._get_query_text("query")
  local parser = vim.treesitter.get_parser(bufnr, "go")

  local tree = parser:parse()

  if tree == nil then
    error("Unable to get query information for filetype")
  end

  print(vim.inspect(parser))
  -- print((tree))
  -- print(vim.inspect(query.root))
  -- print(vim.inspect(x))
end

return M
