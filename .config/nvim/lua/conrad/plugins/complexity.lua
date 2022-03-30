require "nvim-treesitter"

local lsp_proto = vim.lsp.protocol
local utils = require "conrad.utils"
local ts_parsers = require "nvim-treesitter.parsers"

local M = {}
local ns = vim.api.nvim_create_namespace "conrad/complexity"

local attached_buffers = {}

function M.show()
  local buf_number = vim.api.nvim_get_current_buf()

  if attached_buffers[buf_number] then
    return
  end
  attached_buffers[buf_number] = true

  local lang = ts_parsers.get_buf_lang(bufnr):gsub("-", "")

  local query = {
    go = [[
    (function_declaration) @functions
  ]],
    typescript = [[
      (arrow_function) @funcs
      (function_declaration) @funcs
      (return_statement) @edges

      (if_statement) @ifstatements
      (binary_expression) @expressions
      (unary_expression) @expressions

      (parenthesized_expression) @test
    ]],
  }

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
    index = 1

    if match[index] then
      utils.P(match)
      utils.P(match[index]:named())
      -- utils.P(getmetatable(match[index]))
      -- utils.P(getmetatable(metadata))
    else
      index = 2
    end

    if match[index] then
      utils.P(match)
      utils.P(match[index]:named())
      -- utils.P(getmetatable(match[index]))
      -- utils.P(getmetatable(metadata))
    else
      index = 3
    end

    if match[index] then
      utils.P(match)
      utils.P(match[index]:named())
      -- utils.P(getmetatable(match[index]))
      -- utils.P(getmetatable(metadata))
    else
      index = 4
    end

    if match[index] then
      utils.P(match)
      utils.P(match[index]:named())
      -- utils.P(getmetatable(match[index]))
      -- utils.P(getmetatable(metadata))
    else
      index = 5
    end

    if match[index] then
      utils.P(match)
      utils.P(match[index]:named())
      -- utils.P(getmetatable(match[index]))
      -- utils.P(getmetatable(metadata))
    end
    -- utils.P(match[1]:named())
    -- utils.P(match[3])
    -- utils.P(match[4])

    -- utils.P(vim.lsp.protocol.SymbolKind[match[1]:symbol()] or "Unknown")
    -- if match[1]:symbol() == nil then
    --   symbol = vim.lsp.protocol.SymbolKind[match[1]:symbol()]
    -- else
    --   symbol = "Unknown"
    -- end

    -- table.insert(results, {
    --   node_type = match[1]:type(),
    --   start_line = match[1]:start(),
    --   -- symbol = symbol
    -- })
  end

  utils.P(results)

  -- for _, v in ipairs(results) do
  --   utils.setVirtualText(ns, v.start_line, v.node_type, "--")
  -- end

  -- utils.P(getmetatable(captures[1]))
  -- utils.P(lsp_proto.SymbolKind[node:symbol()] or "Unknown")
end

return M
