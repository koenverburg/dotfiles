local ts_utils = require "nvim-treesitter.ts_utils"
local q = vim.treesitter.query
local ts = vim.treesitter
local api = vim.api

function get_query_matches(buffer, lang, query_str)
  buffer = buffer or api.nvim_get_current_buf()
  local root = ts.get_parser(buffer, lang):parse()[1]:root()
  local query = ts.parse_query(lang, query_str)
  return query:iter_matches(root, buffer)
end


local query = [[
  (lexical_declaration
    (variable_declarator
      name: (identifier) @myElements)
  )
]]

local match_iter = get_query_matches(buffer, 'typescript', query)

for _, match, metadata in match_iter do
  --
  print(vim.inspect(match))
  print(q.get_node_text(match[1], 0))
  print(match[1]:range())
  -- print(vim.inspect(getmetatable(match[1])))
end

local highlight = function(group, attr, sp)
  attr = attr and "gui=" .. attr or "gui=NONE"
  sp = sp and "guisp=" .. sp or ""

  vim.api.nvim_command("highlight " .. group .. " ".. attr .. " " .. sp)
end
