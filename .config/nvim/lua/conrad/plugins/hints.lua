local ts_utils = require "nvim-treesitter.ts_utils"

local function P(value)
  print(vim.inspect(value))
  return value
end

local M = {}
local api, util = vim.api, vim.lsp.util

local ns = api.nvim_create_namespace "conrad/hints"

function M.setup_autocmd()
  api.nvim_command "augroup hints"
  api.nvim_command 'autocmd BufEnter,BufWinEnter,TabEnter,BufWritePost *.ts,*.tsx,*.js,*.jsx :lua require"conrad.plugins.inlays".show()'
  api.nvim_command "augroup END"
end

local function setVirtualText(node, text)
  local targetLineNumber = node:start()
  local virtualText = " << " .. text
  api.nvim_buf_set_virtual_text(0, ns, targetLineNumber, { { virtualText, "Comment" } }, {})
end

local lsp_proto = require "vim.lsp.protocol"

-- the symbol kinds which are valid scopes
local scope_kinds = {
  Class = true,
  Function = true,
  Method = true,
  Struct = true,
  Enum = true,
  Interface = true,
  Namespace = true,
  Module = true,
}

local function filter(list, test)
  local result = {}
  for i, v in ipairs(list) do
    if test(i, v) then
      table.insert(result, v)
    end
  end

  return result
end

local function extract_symbols(items, _result)
  local result = _result or {}
  if items == nil then
    return result
  end
  for _, item in ipairs(items) do
    local kind = lsp_proto.SymbolKind[item.kind] or "Unknown"
    local sym_range = nil
    if item.location then -- Item is a SymbolInformation
      sym_range = item.location.range
    elseif item.range then -- Item is a DocumentSymbol
      sym_range = item.range
    end

    if sym_range then
      sym_range.start.line = sym_range.start.line + 1
      sym_range["end"].line = sym_range["end"].line + 1
    end

    table.insert(result, {
      filename = item.location and vim.uri_to_fname(item.location.uri) or nil,
      range = sym_range,
      kind = kind,
      text = item.name,
      raw_item = item,
    })

    if item.children then
      extract_symbols(item.children, result)
    end
  end

  return result
end

local function handler(_, result)
  if type(result) ~= "table" then
    print "no results"
    return
  end

  local r = filter(extract_symbols(result), function(_, v)
    return scope_kinds[v.kind]
  end)
  print(vim.inspect(r))
end

function M.show()
  -- local node = ts_utils.get_node_at_cursor()
  -- if not node then
  --   vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
  --   return
  -- end
  -- P(node:type())

  local params = { textDocument = util.make_text_document_params() }
  vim.lsp.buf_request(0, "textDocument/documentSymbol", params, handler)

  -- setVirtualText(node, "hii")
end

return M
