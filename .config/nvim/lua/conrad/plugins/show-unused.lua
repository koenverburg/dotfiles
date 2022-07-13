local utils = require "conrad.utils"
local ts_helpers = require "conrad.utils.treesitter"
local ts_utils = require "nvim-treesitter.ts_utils"
local ts_parsers = require "nvim-treesitter.parsers"

local M = {}
local ns = vim.api.nvim_create_namespace "conrad/references"

local queries = {
  typescript = [[
    (variable_declarator) @captures
    (arrow_function) @captures
    (function_declaration) @captures
    (generator_function_declaration) @captures
  ]],
  go = [[
    (var_declaration) @captures
    (function_declaration) @captures
    (short_var_declaration) @captures
  ]],
}

function M.reference_handler(err, locations, ctx, _)
  if err then
    vim.notify "Error looking for references"
    return
  end

  if not locations or vim.tbl_isempty(locations) then
    vim.notify "No reference found"
    return
  end

  local line = ctx.params.position.line

  if #locations - 1 > 0 then
    utils.setVirtualText(ns, line, #locations - 1, "References")
  else
    utils.setVirtualText(ns, line, "Unused code", nil)
  end
end

function M._get_language_query(bufnr)
  local lang = ts_parsers.get_buf_lang(bufnr):gsub("-", "")
  local current_query = queries[lang]

  if not current_query then
    vim.notify "Error: queries for this languages are not implemented"
    return nil
  end

  return current_query
end

function M._create_to_lsp_param(bufnr, node)
  local range = ts_utils.node_to_lsp_range(node)

  local params = {
    textDocument = vim.lsp.util.make_text_document_params(bufnr),
    position = {
      line = range.start.line,
      character = range.start.character,
    },
    context = {
      includeDeclaration = true,
    },
  }

  return params
end

function M._find_references(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()

  local query = M._get_language_query(bufnr)
  if not query then
    return
  end

  local matches = ts_helpers.get_query_matches(bufnr, query)

  for _, match, _ in matches do
    local params = M._create_to_lsp_param(bufnr, match[1])

    vim.lsp.buf_request(bufnr, "textDocument/references", params, M.reference_handler)
  end
end

function M.set_autocmd(bufnr)
  vim.api.nvim_create_autocmd("InsertLeave", {
    callback = function()
      require("conrad.plugins.show-unused")._find_references(bufnr)
    end,
  })
end

function M.on_attach(client, bufnr)
  M._find_references(bufnr)
  M.set_autocmd(bufnr)
end

return M
