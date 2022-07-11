local utils = require "conrad.utils"
local ts_utils = require "nvim-treesitter.ts_utils"
local ts_parsers = require "nvim-treesitter.parsers"
local lsp_proto = vim.lsp.protocol

local M = {}

local function P(value)
  print(vim.inspect(value))
end

local query = {
  go = "(import_declaration) @imports",
  tsx = "(import_statement) @imports",

  javascript = "(import_statement) @imports",
  typescript = "(import_statement) @imports",

  javascriptreact = "(import_statement) @imports",
  typescriptreact = "(import_statement) @imports",
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

function foldTypescript(matches)
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

function M.main()
  local buf_number = vim.api.nvim_get_current_buf()
  local lang = ts_parsers.get_buf_lang(buf_number):gsub("-", "")

  if not query[lang] then
    print(string.format("Unsupported languages found: %s", lang))
    return
  end

  local matches = utils.get_query_matches(buf_number, query[lang])
  if matches == nil then
    return
  end

  if lang == "go" then
    foldGo(matches)
  end

  if lang == "typescript" or lang == "tsx" then
    foldTypescript(matches)
  end
end

return M
