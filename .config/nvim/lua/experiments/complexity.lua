local utils = require "_apache.utils"
local ts_helpers = require "_apache.utils"
local ts_utils = require "nvim-treesitter.ts_utils"
local ts_parsers = require "nvim-treesitter.parsers"

local P = utils.P

local M = {}
local ns = vim.api.nvim_create_namespace "conrad/complexity"


-- LabelStatement: 1,
-- BreakStatement: 1,
-- GotoStatement: 1,
-- ReturnStatement: 1,
-- IfStatement: 1,
-- IfClause: 1,
-- ElseifClause: 1,
-- ElseClause: 1,
-- WhileStatement: 1,
-- DoStatement: 1,
-- RepeatStatement: 1,
-- LocalStatement: 0,
-- AssignmentStatement: 0,
-- CallStatement: 0,
-- FunctionDeclaration: 1,
-- ForNumericStatement: 1,
-- ForGenericStatement: 1,
-- Chunk: 0,
-- Identifier: 0,
-- StringLiteral: 0,
-- NumericLiteral: 0,
-- BooleanLiteral: 0,
-- NilLiteral: 0,
-- VarargLiteral: 0,
-- TableKey: 0,
-- TableKeyString: 0,
-- TableValue: 0,
-- TableConstructorExpression: 0,
-- UnaryExpression: 0,
-- MemberExpression: 1,
-- IndexExpression: 0,
-- CallExpression: 0,
-- TableCallExpression: 0,
-- StringCallExpression: 0,
-- Comment: 0

local logic_queries = {
  'lexical_declaration',
  'variable_declarator',
  'return_statement'
}

local js = [[
  (arrow_function) @captures
  (function_declaration) @captures
  (generator_function_declaration) @captures
]]

local queries = {
  tsx = js,
  typescript = js,
  javascript = js,
  go = [[
    (func_literal) @captures
    (method_declaration) @captures
    (function_declaration) @captures
  ]],
}

function M._get_language_query(bufnr)
  local lang = ts_parsers.get_buf_lang(bufnr):gsub("-", "")
  local current_query = queries[lang]

  if not current_query then
    vim.notify "Error: queries for this languages are not implemented"
    return nil, lang
  end

  return current_query, lang
end

function M._get_functions()
  local bufnr = vim.api.nvim_get_current_buf()

  local query, lang = M._get_language_query(bufnr)
  if not query then
    return
  end

  local matches = ts_helpers.get_query_matches(bufnr, query)

  for _, match, _ in matches do

    local parsed = vim.treesitter.parse_query(lang, query)

    local results = parsed:iter_matches(match[1], bufnr)
    -- local logical_matches = ts_helpers.walk_down(match[1], logic_queries)
    P(getmetatable(results))

    -- P(match[1]:_)
    -- P(match[1]:child():type())
    -- P(match[1].__tostring())

    local line = match[1]:start()
    utils.setVirtualText(ns, line, 0, "cc")
  end
end

function M.set_autocmd()
  vim.api.nvim_create_autocmd("BufWrite", {
    callback = function()
      require("conrad.complexity")._get_functions()
    end,
  })
end

M.set_autocmd()

-- function M.on_attach(client, bufnr)
--   M._get_functions(bufnr)
--   -- M.set_autocmd(bufnr)
-- end

return M
