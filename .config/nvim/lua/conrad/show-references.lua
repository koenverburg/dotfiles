local utils = require("_apache.utils")
local ts_utils = require("nvim-treesitter.ts_utils")
local ts_parsers = require("nvim-treesitter.parsers")

local M = {}
local ns = vim.api.nvim_create_namespace("conrad/references")

local queries = {
  typescript = [[
    (lexical_declaration) @captures
    (variable_declarator) @captures
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
    print("Error looking for references")
    return
  end

  if not locations or vim.tbl_isempty(locations) then
    print("No reference found")
    return
  end

  local line = ctx.params.position.line

  if #locations - 1 > 0 then
    utils.setVirtualText(ns, line, #locations - 1, "R")
  else
    utils.setVirtualText(ns, line, "Unused code", nil)
  end
end

local mapTo = function(lang)
  if lang == "typescriptreact" or lang == "tsx" then
    return "typescript"
  end

  if lang == "javascriptreact" or lang == "jsx" then
    return "javascript"
  end

  return lang
end

local function get_language_query(bufnr)
  local lang = ts_parsers.get_buf_lang(bufnr):gsub("-", "")
  local current_query = queries[mapTo(lang)]

  if not current_query then
    print("Error: queries for this languages are not implemented")
    return nil
  end

  return current_query
end

local function convert_to_lsp_param(bufnr, node)
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
  local original_lang = ts_parsers.get_buf_lang(bufnr):gsub("-", "")
  local lang = mapTo(original_lang)

  local query = get_language_query(bufnr)
  if not query then
    print("references - cant find query for " .. query)
    return
  end

  local matches = utils.get_query_matches(bufnr, lang, query)
  for _, match, _ in matches do
    local params = convert_to_lsp_param(bufnr, match[1])
    vim.lsp.buf_request(bufnr, "textDocument/references", params, M.reference_handler)
  end
end

function M.set_autocmd(bufnr)
  vim.api.nvim_create_autocmd({ "InsertLeave", "BufEnter", "BufWritePost", "BufWrite" }, {
    callback = function()
      local references = require("conrad.show-references")
      vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)

      if references.is_supported(bufnr) then
        references._find_references(bufnr)
      end
    end,
  })
end

function M.is_supported(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  local lang = ts_parsers.get_buf_lang(bufnr):gsub("-", "")

  if lang == "typescript" or lang == "typescriptreact" or lang == "tsx" then
    return true
  elseif lang == "go" then
    return true
  end

  return false
end

function M.on_attach(_, bufnr)
  M._find_references(bufnr)
  -- M.set_autocmd(bufnr)
end

return M
