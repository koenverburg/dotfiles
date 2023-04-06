local M = {}
local utils = require("_apache.utils")

local signs = {
  error = {name = "DiagnosticSignError", text = ""},
  warn = {name = "DiagnosticSignWarn", text = ""},
  hint = {name = "DiagnosticSignHint", text = ""},
  info = {name = "DiagnosticSignInfo", text = ""}
}

local ns = vim.api.nvim_create_namespace("conrad/static-info")

local function_queriess = [[
  (function) @captures
  (arrow_function) @captures
  (function_declaration) @captures
  (generator_function_declaration) @captures
]]

local exit_queries = [[ (return_statement) @captures ]]

local function query_for_returns(bufnr, lang, function_tree)
  if lang == 'typescriptreact' then
    lang = 'typescript'
  end

  local parsed = vim.treesitter.parse_query(lang, exit_queries)

  for _, match in parsed:iter_matches(function_tree, bufnr) do
    for _, node in pairs(match) do
      local func_end = tostring(function_tree:end_() - 1)
      local node_end = tostring(node:end_())

      if func_end == node_end  then
        utils.setVirtualText(ns, node:start(), "original exit", signs.info.text)
      else
        utils.setVirtualText(ns, node:start(), "early exit", signs.info.text)
      end
    end
  end
end

local function query_buffer(bufnr, queries)
  local parser = vim.treesitter.get_parser(bufnr, vim.bo.filetype)

  if not parser then
    return nil
  end

  local tree = parser:parse()
  local root = tree[1]:root()

  local lang = parser:lang()
  if lang == 'typescriptreact' then
    lang = 'typescript'
  end

  local parsed = vim.treesitter.parse_query(lang, queries)

  return parser, parsed, root
end

function M.show_early_exit()
  local bufnr = vim.api.nvim_get_current_buf()

  local parser, parsed, root = query_buffer(bufnr, function_queriess)
  for _, match in parsed:iter_matches(root, bufnr) do
    for _, node in pairs(match) do
      query_for_returns(bufnr, parser:lang(), node)
    end
  end
end

local import_query = [[ (import_statement) @captures ]]
function M.show_named_imports()
  local bufnr = vim.api.nvim_get_current_buf()

  local parser, parsed, root = query_buffer(bufnr, import_query)
  for _, match in parsed:iter_matches(root, bufnr) do
    for _, node in pairs(match) do
      local text = vim.treesitter.query.get_node_text(node, bufnr)

      if string.match(text, "* as") then
        utils.setVirtualText(ns, node:start(), "Star import found", signs.error.text, signs.error.name)
      elseif not string.match(text, "{") then
        utils.setVirtualText(ns, node:start(), "Named import found", signs.error.text, signs.error.name)
      end
    end
  end
end

local exports_query = [[ (export_statement) @captures ]]
function M.show_default_exports()
  local bufnr = vim.api.nvim_get_current_buf()

  local parser, parsed, root = query_buffer(bufnr, exports_query)
  for _, match in parsed:iter_matches(root, bufnr) do
    for _, node in pairs(match) do
      local text = vim.treesitter.query.get_node_text(node, bufnr)

      if string.match(text, "default") then
        utils.setVirtualText(ns, node:start(), "Default export found", signs.error.text, signs.error.name)
      end
    end
  end
end

function M.main()
  M.show_early_exit()
  M.show_named_imports()
  M.show_default_exports()
end

return M
