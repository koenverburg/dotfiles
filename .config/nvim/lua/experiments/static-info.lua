local utils = require("_apache.utils")
local ts = require('nvim-treesitter')
local parsers = require('nvim-treesitter.parsers')
local ts_utils = require('nvim-treesitter.ts_utils')

local M = {}
local api = vim.api
local get_node_text = vim.treesitter.get_node_text or vim.treesitter.query.get_node_text
local parse_query = vim.treesitter.query.parse

local ns_cc = vim.api.nvim_create_namespace("conrad/cyclomatic_complexity")
local ns_imports = vim.api.nvim_create_namespace("conrad/imports")
local ns_references = vim.api.nvim_create_namespace("conrad/references")
local ns_early_exit = vim.api.nvim_create_namespace("conrad/early-exit")
local ns_default_exports = vim.api.nvim_create_namespace("conrad/default_exports")

local signs = {
  error = { highlightGroup = "DiagnosticSignError", icon = "" },
  warn = { highlightGroup = "DiagnosticSignWarn", icon = "" },
  hint = { highlightGroup = "DiagnosticSignHint", icon = "" },
  info = { highlightGroup = "DiagnosticSignInfo", icon = "" },
}

local supported_filetypes = {
  -- "javascript",
  -- "javascriptreact",
  "typescript",
  "typescriptreact",
  "tsx",
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
    callback = callback,
  })
end

-- (variable_declarator) @captures
-- (arrow_function) @captures
local function_queriess = [[
  (function) @captures
  (arrow_function) @captures
  (method_definition) @captures
  (lexical_declaration) @captures
  (function_declaration) @captures
  (generator_function_declaration) @captures
]]
local exit_queries = [[ (return_statement) @captures ]]
local import_query = [[ (import_statement) @captures ]]
local inverseable_ifs_queries = [[ (unary_expression) @captures ]]

local function query_for_returns(namespace, bufnr, lang, function_tree)
  if lang == "typescriptreact" then
    lang = "tsx"
  end

  local parsed = parse_query(lang, exit_queries)

  for _, match in parsed:iter_matches(function_tree, bufnr) do
    for _, node in pairs(match) do
      local func_end = tostring(function_tree:end_() - 1)
      local node_end = tostring(node:end_())

      if func_end == node_end then
        utils.setVirtualText(namespace, node:start(), "original exit", signs.info.icon, nil) -- signs.info.highlightGroup)
      else
        utils.setVirtualText(namespace, node:start(), "early exit", signs.info.icon, nil) -- signs.info.highlightGroup)
      end
    end
  end
end

local function query_for_if_statemenets(namespace, bufnr, lang, function_tree)
  if lang == "typescriptreact" then
    lang = "tsx"
  end

  local parsed = parse_query(lang, inverseable_ifs_queries)

  for _, match in parsed:iter_matches(function_tree, bufnr) do
    for _, node in pairs(match) do
      local func_start = tostring(function_tree:start())
      local node_start = tostring(node:start())

      print(func_start, node_start)

      -- if func_start == node_start then
      --   utils.setVirtualText(namespace, node:start(), "original exit", signs.info.text, signs.info.name)
      -- else
      --   utils.setVirtualText(namespace, node:start(), "early exit", signs.info.text, signs.info.name)
      -- end
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
  local parsed = parse_query(lang, queries)

  return parser, parsed, root
end

function M.show_early_exit()
  local bufnr = vim.api.nvim_get_current_buf()
  if not M.enabled_when_supprted_filetype(bufnr) then
    return
  end

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
      query_for_returns(ns_early_exit, bufnr, parser:lang(), node)
    end
  end
end

function M.show_named_imports()
  local bufnr = vim.api.nvim_get_current_buf()
  if not M.enabled_when_supprted_filetype(bufnr) then
    return
  end

  local _, parsed, root = query_buffer(bufnr, import_query)
  if not parsed then
    return
  end
  for _, match in parsed:iter_matches(root, bufnr) do
    for _, node in pairs(match) do
      local text = get_node_text(node, bufnr)

      if string.match(text, "* as") then
        utils.setVirtualText(
          ns_imports,
          node:start(),
          "Star import found",
          signs.error.text,
          signs.error.highlightGroup
        )
      elseif not string.match(text, "{") then
        utils.setVirtualText(
          ns_imports,
          node:start(),
          "Named import found",
          signs.error.text,
          signs.error.highlightGroup
        )
      end
    end
  end
end

function M.show_default_exports()
  local bufnr = vim.api.nvim_get_current_buf()
  if not M.enabled_when_supprted_filetype(bufnr) then
    return
  end

  local exports_query = [[ (export_statement) @captures ]]
  local _, parsed, root = query_buffer(bufnr, exports_query)
  if not parsed then
    return
  end
  for _, match in parsed:iter_matches(root, bufnr) do
    for _, node in pairs(match) do
      local text = get_node_text(node, bufnr)

      if string.match(text, "export default") then
        utils.setVirtualText(
          ns_default_exports,
          node:start(),
          "Default export found",
          signs.error.text,
          signs.error.highlightGroup
        )
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
    utils.setVirtualText(ns_references, line, "R " .. count, nil, signs.hint.highlightGroup)
    -- utils.setVirtualText(ns_references, line, "R " .. count, signs.info.icon, signs.info.highlightGroup)
  else
    utils.setVirtualText(ns_references, line, "Unused code", signs.error.icon, signs.error.highlightGroup)
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
  if not M.enabled_when_supprted_filetype(bufnr) then
    return
  end

  local _, parsed, root = query_buffer(bufnr, function_queriess)

  if not parsed then
    return
  end

  for _, match in parsed:iter_matches(root, bufnr) do
    local params = convert_to_lsp_param(bufnr, match[1])
    vim.lsp.buf_request(bufnr, "textDocument/references", params, reference_handler)
  end
end

local function recurse_tree(node)
  local nested_count = 0

  for _, child_node in ipairs(node:named_children()) do
    if child_node:type() == "statement_block" then
      for _, body in ipairs(child_node:named_children()) do
        local child_type = body:type()

        if
          child_type == "lexical_declaration"
          or child_type == "catch_clause"
          or child_type == "switch_case"
          or child_type == "switch_default"

          or child_type == "yield_expression"
          or child_type == "binary_expression"
          or child_type == "member_expression"
          or child_type == "logical_expression"
          or child_type == "conditional_expression"
        then
          nested_count = nested_count + 1
          -- utils.setVirtualText(ns_cc, body:start(), "+1", "cc", nil) -- signs.info.highlightGroup)
        end


        if
          child_type == "if_statement"
          or child_type == "do_statement"
          or child_type == "for_statement"
          or child_type == "try_statement"
          or child_type == "case_statement"
          or child_type == "while_statement"
          or child_type == "throw_statement"
          or child_type == "return_statement"
          or child_type == "for_in_statement"
          or child_type == "switch_statement"
          or child_type == "default_statement"
          or child_type == "expression_statement"
        then
          nested_count = nested_count + recurse_tree(body)
          -- utils.setVirtualText(ns_cc, body:start(), "+1", "cc", nil) -- signs.info.highlightGroup)
        end
      end
    end
  end

  return nested_count
end

function M.show_cyclomatic_complexity(bufnr)
  bufnr = bufnr or api.nvim_get_current_buf()
  if not M.enabled_when_supprted_filetype(bufnr) then
    return
  end

  local _, parsed, root = query_buffer(bufnr, function_queriess)
  if not parsed then
    print("Error: buffer does not have a TypeScript or JavaScript parser")
    return
  end

  for _, match in parsed:iter_matches(root, bufnr) do
    local node = match[1]
    local complexity = 1

    for _, child_node in ipairs(node:named_children()) do
      if child_node:type() == "statement_block" then
        for _, body in ipairs(child_node:named_children()) do
          local child_type = body:type()

          if
            child_type == "lexical_declaration"
            or child_type == "catch_clause"
            or child_type == "switch_case"
            or child_type == "switch_default"

            or child_type == "yield_expression"
            or child_type == "member_expression"
            or child_type == "binary_expression"
            or child_type == "logical_expression"
            or child_type == "conditional_expression"

            or child_type == "if_statement"
            or child_type == "do_statement"
            or child_type == "for_statement"
            or child_type == "try_statement"
            or child_type == "case_statement"
            or child_type == "while_statement"
            or child_type == "throw_statement"
            or child_type == "return_statement"
            or child_type == "for_in_statement"
            or child_type == "switch_statement"
            or child_type == "default_statement"
            or child_type == "expression_statement"
          then
            complexity = complexity + 1
            -- utils.setVirtualText(ns_cc, body:start(), "+1", "cc", nil) -- signs.info.highlightGroup)
          end

        if
          child_type == "if_statement"
          or child_type == "do_statement"
          or child_type == "for_statement"
          or child_type == "try_statement"
          or child_type == "case_statement"
          or child_type == "while_statement"
          or child_type == "throw_statement"
          or child_type == "return_statement"
          or child_type == "for_in_statement"
          or child_type == "switch_statement"
          or child_type == "default_statement"
          or child_type == "expression_statement"
        then
          complexity = complexity + 1
          complexity = complexity + recurse_tree(body)
          -- utils.setVirtualText(ns_cc, body:start(), "+1", "cc", nil) -- signs.info.highlightGroup)
        end


        end
      end
    end

    if complexity > 1 then
      if complexity < 10 then
        utils.setVirtualText(ns_cc, node:start(), complexity, "cc", nil) -- signs.info.highlightGroup)
      elseif complexity > 10 and complexity < 15 then
        utils.setVirtualText(ns_cc, node:start(), complexity, "cc", signs.hint.highlightGroup)
      else
        utils.setVirtualText(ns_cc, node:start(), complexity, "cc", signs.warn.highlightGroup)
      end
    end
  end
end

function M.format(bufnr)
  bufnr = bufnr or api.nvim_get_current_buf()
  if not M.enabled_when_supprted_filetype(bufnr) then
    return
  end

  local order_queries = [[
    (import_statement) @imports
  ]]
  -- (type_alias_declaration) @types
  -- (interface_declaration) @types
  -- (export_statement) @exports
  --
  -- (function) @functions
  -- (method_definition) @functions
  -- (lexical_declaration) @functions
  -- (function_declaration) @functions
  -- (generator_function_declaration) @functions

  local _, parsed, root = query_buffer(bufnr, order_queries)

  if not parsed then
    return
  end

  local edits = {}

  local lines = 0

  for _, match in parsed:iter_matches(root, bufnr) do
    for _, node in pairs(match) do
      local range = ts_utils.node_to_lsp_range(node)

      -- print(vim.inspect(range))

      range["end"].line = lines
      range.start.line = lines

      -- local text = get_node_text(node, bufnr)
      -- print(text)

      local text_edit = { range = range, newText = get_node_text(node, bufnr) }
      table.insert(edits, text_edit)
      lines = lines + 1
    end
    lines = lines + 1
  end

  -- print(vim.inspect(edits))

  vim.lsp.util.apply_text_edits(edits, bufnr, "utf-8")
end

function M.enabled_when_supprted_filetype(bufnr)
  local filetype = vim.api.nvim_buf_get_option(bufnr, "ft")

  if utils.contains(supported_filetypes, filetype) then
    return true
  end

  return false
end

function M.main()
  -- M.show_reference()
  M.show_early_exit()
  M.show_named_imports()
  M.show_default_exports()
  M.show_cyclomatic_complexity()
end

function M.autocmd()
  register_autocmd(function()
    vim.api.nvim_buf_clear_namespace(0, ns_cc, 0, -1)
    vim.api.nvim_buf_clear_namespace(0, ns_imports, 0, -1)
    vim.api.nvim_buf_clear_namespace(0, ns_references, 0, -1)
    vim.api.nvim_buf_clear_namespace(0, ns_early_exit, 0, -1)
    vim.api.nvim_buf_clear_namespace(0, ns_default_exports, 0, -1)

    -- M.show_reference()
    M.show_early_exit()
    M.show_named_imports()
    M.show_default_exports()
    M.show_cyclomatic_complexity()
  end)
end

return M
