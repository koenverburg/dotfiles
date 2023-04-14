local M = {}
local api = vim.api
local get_node_text = vim.treesitter.get_node_text or vim.treesitter.query.get_node_text

local utils = require("_apache.utils")
local ts_utils = require("nvim-treesitter.ts_utils")
local ns = vim.api.nvim_create_namespace("conrad/static-info")

local signs = {
  error = { name = "DiagnosticSignError", text = "" },
  warn = { name = "DiagnosticSignWarn", text = "" },
  hint = { name = "DiagnosticSignHint", text = "" },
  info = { name = "DiagnosticSignInfo", text = "" },
}

local supported_filetypes = {
  "javascript",
  "typescript",
  "javascriptreact",
  "typescriptreact",
  "tsx"
}

local function register_autocmd(callback)
  local augroup = "conrad_static_info"
  local events = {
    "LspAttach",
    "BufEnter",
    "BufWritePost",
    "DiagnosticChanged",
  }
  vim.api.nvim_create_augroup(augroup, {})
  vim.api.nvim_create_autocmd(events, {
    group = augroup,
    callback = callback
  })
end

-- (variable_declarator) @captures
-- (arrow_function) @captures
local function_queriess = [[
  (function) @captures
  (lexical_declaration) @captures
  (function_declaration) @captures
  (generator_function_declaration) @captures
]]
local exit_queries = [[ (return_statement) @captures ]]
local import_query = [[ (import_statement) @captures ]]
local exports_query = [[ (export_statement) @captures ]]

local function query_for_returns(bufnr, lang, function_tree)
  if lang == "typescriptreact" then
    lang = "tsx"
  end

  local parsed = vim.treesitter.parse_query(lang, exit_queries)

  for _, match in parsed:iter_matches(function_tree, bufnr) do
    for _, node in pairs(match) do
      local func_end = tostring(function_tree:end_() - 1)
      local node_end = tostring(node:end_())

      if func_end == node_end then
        utils.setVirtualText(ns, node:start(), "original exit", signs.info.text, signs.info.name)
      else
        utils.setVirtualText(ns, node:start(), "early exit", signs.info.text, signs.info.name)
      end
    end
  end
end

local function query_buffer(bufnr, queries)
  local filetype = vim.api.nvim_buf_get_option(bufnr, "ft")
  local lang = require("nvim-treesitter.parsers").ft_to_lang(filetype)

  local parser = vim.treesitter.get_parser(bufnr, lang)
  if not parser then
    return nil
  end

  local tree = parser:parse()
  local root = tree[1]:root()
  local parsed = vim.treesitter.parse_query(lang, queries)

  return parser, parsed, root
end

function M.show_early_exit()
  local bufnr = vim.api.nvim_get_current_buf()
  if not M.enabled_when_supprted_filetype(bufnr) then return end

  local parser, parsed, root = query_buffer(bufnr, function_queriess)
  if not parsed then
    return
  end
  for _, match in parsed:iter_matches(root, bufnr) do
    for _, node in pairs(match) do
      if not parser then
        vim.notify("parser not found")
        return
      end
      query_for_returns(bufnr, parser:lang(), node)
    end
  end
end

function M.show_named_imports()
  local bufnr = vim.api.nvim_get_current_buf()
  if not M.enabled_when_supprted_filetype(bufnr) then return end

  local _, parsed, root = query_buffer(bufnr, import_query)
  if not parsed then
    return
  end
  for _, match in parsed:iter_matches(root, bufnr) do
    for _, node in pairs(match) do
      local text = get_node_text(node, bufnr)

      if string.match(text, "* as") then
        utils.setVirtualText(ns, node:start(), "Star import found", signs.error.text, signs.error.name)
      elseif not string.match(text, "{") then
        utils.setVirtualText(ns, node:start(), "Named import found", signs.error.text, signs.error.name)
      end
    end
  end
end

function M.show_default_exports()
  local bufnr = vim.api.nvim_get_current_buf()
  if not M.enabled_when_supprted_filetype(bufnr) then return end

  local _, parsed, root = query_buffer(bufnr, exports_query)
  if not parsed then
    return
  end
  for _, match in parsed:iter_matches(root, bufnr) do
    for _, node in pairs(match) do
      local text = get_node_text(node, bufnr)

      if string.match(text, "default") then
        utils.setVirtualText(ns, node:start(), "Default export found", signs.error.text, signs.error.name)
      end
    end
  end
end

local function reference_handler(err, locations, ctx, _)
  if err then
    return
  end

  if not locations or vim.tbl_isempty(locations) then
    return
  end

  local line = ctx.params.position.line
  local count = #locations - 1

  if count > 0 then
    utils.setVirtualText(ns, line, "R " .. count, signs.info.text, signs.info.name)
  else
    utils.setVirtualText(ns, line, "Unused code", signs.error.text, signs.error.name)
  end
end

local function convert_to_lsp_param(bufnr, node)
  local range = ts_utils.node_to_lsp_range(node)
  return {
    textDocument = vim.lsp.util.make_text_document_params(bufnr),
    position = {
      line = range.start.line,
      character = range.start.character,
    },
    context = {
      includeDeclaration = true,
    },
  }
end

function M.show_reference(bufnr)
  bufnr = bufnr or api.nvim_get_current_buf()
  if not M.enabled_when_supprted_filetype(bufnr) then return end

  local _, parsed, root = query_buffer(bufnr, function_queriess)

  if not parsed then
    return
  end

  for _, match in parsed:iter_matches(root, bufnr) do
    local params = convert_to_lsp_param(bufnr, match[1])
    vim.lsp.buf_request(bufnr, "textDocument/references", params, reference_handler)
  end

end

function M.enabled_when_supprted_filetype(bufnr)
  local filetype = vim.api.nvim_buf_get_option(bufnr, "ft")

  if utils.contains(supported_filetypes, filetype) then
    return true
  end

  return false
end


function M.main()
  M.show_reference()
  M.show_early_exit()
  M.show_named_imports()
  M.show_default_exports()
end

function M.autocmd()
  register_autocmd(function ()
    -- vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)

    M.show_reference()
    M.show_early_exit()
    M.show_named_imports()
    M.show_default_exports()
  end)
end

return M
