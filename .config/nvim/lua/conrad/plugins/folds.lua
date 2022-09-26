local utils = require "conrad.utils"
local ts_helpers = require "conrad.utils.treesitter"
local ts_utils = require "nvim-treesitter.ts_utils"
local ts_parsers = require "nvim-treesitter.parsers"
local lsp_proto = vim.lsp.protocol

local M = {}

local P = utils.P

local js = "(import_statement) @imports"

local queries = {
  go = "(import_declaration) @imports",

  javascript = js,
  tsx = js,
  typescript = js,
}

-- zE will remove markers
-- za will toggle folds

function foldGo(matches)
  for _, match, metadata in matches do
    local start_line = match[1]:start() + 1
    local end_line = match[1]:end_() + 1

    vim.cmd(string.format("%s,%s fold", start_line, end_line))
  end
end

function foldXscript(matches)
  local index = 1
  local start_fold_line = 0
  local end_fold_line = 0

  for _, match, metadata in matches do
    local start_line = match[1]:start()
    local end_line = match[1]:end_()

    if index == 1 then
      start_fold_line = start_line
    end

    if end_line > end_fold_line then
      end_fold_line = end_line
    end

    index = index + 1
  end

  vim.cmd(string.format("%s,%s fold", start_fold_line, end_fold_line + 1))
end

function mapTo(lang)
  if lang == "typescriptreact" or lang == "tsx" then
    return "typescript"
  end

  if lang == "javascriptreact" then
    return "javascript"
  end

  return lang
end

function M._get_language_query(lang, bufnr)
  local current_query = queries[mapTo(lang)]

  if not current_query then
    vim.notify "Error: queries for this languages are not implemented"
    return nil
  end

  return current_query
end

function M.main()
  local bufnr = vim.api.nvim_get_current_buf()
  local lang = ts_parsers.get_buf_lang(bufnr):gsub("-", "")

  local query = M._get_language_query(lang, bufnr)
  if not query then
    return
  end

  local matches = ts_helpers.get_query_matches(bufnr, query)
  if matches == nil then
    return
  end

  if lang == "go" then
    foldGo(matches)
  end

  if lang == "typescript" then
    foldXscript(matches)
  end
end

return M
