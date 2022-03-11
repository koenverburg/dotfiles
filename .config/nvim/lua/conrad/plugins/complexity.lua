require "nvim-treesitter"
local utils = require "conrad.utils"
local ts_parsers = require "nvim-treesitter.parsers"

local M = {}
local ns = vim.api.nvim_create_namespace "conrad/hints"

local attached_buffers = {}
function M.show()
  local buf_number = vim.api.nvim_buf_get_number "%"

  if attached_buffers[buf_number] then
    return
  end
  attached_buffers[buf_number] = true

  local lang = ts_parsers.get_buf_lang(bufnr):gsub("-", "")

  local query = {
    go = [[
    (function_declaration) @functions
  ]],
    -- typescript = [[]],
  }

  if not query[lang] then
    print(string.format("Unsupported languages found: %s", lang))
    return
  end

  local matches = utils.get_query_matches(bufnr, query[lang])
  if matches == nil then
    return
  end

  local results = {}
  for _, match, metadata in matches do
    table.insert(results, {
      node_type = match[1]:type(),
      start_line = match[1]:start(),
    })
  end

  for _, v in ipairs(results) do
    utils.setVirtualText(ns, v.start_line, v.node_type, "--")
  end

  -- utils.P(getmetatable(captures[1]))
  -- utils.P(lsp_proto.SymbolKind[node:symbol()] or "Unknown")
end

return M
