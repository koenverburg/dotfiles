local M = {}

-- Initialize Tree-sitter
local ts = require('nvim-treesitter')
local ts_parsers = require "nvim-treesitter.parsers"
-- ts.setup({ ensure_installed = { 'javascript', 'typescript' }, highlight = { enable = true } })
-- ts.highlighter.enabled = true

-- Function to find performance improvement suggestions
M.findPerformanceSuggestions = function(bufnr)
  -- local parser = vim.treesitter.get_parser(bufnr, 'javascript')
  local query = [[
    (function_declaration
      name: (identifier) @function_name
      body: (block
        (expression_statement
          (binary_expression
            left: (identifier) @left_variable
            operator: /<[*\/]/
            right: (numeric_literal) @right_value)))))
  ]]
  local parsed = vim.treesitter.query.parse('typescript', query)

  local matches = {}

  local function capture_match(_, match)
    print(vim.inspect(match))

    -- table.insert(matches, {
    --   function_name = match.captures[1][1],
    --   left_variable = match.captures[2][1],
    --   right_value = match.captures[3][1]
    -- })
  end

  parsed:iter_matches(capture_match)

  return matches
end

-- Function to highlight performance improvement suggestions
M.highlightPerformanceSuggestions = function(bufnr, suggestions)
  local highlight_namespace = vim.api.nvim_create_namespace('performance_suggestions')
  vim.api.nvim_buf_clear_namespace(bufnr, highlight_namespace, 0, -1)

  for _, suggestion in ipairs(suggestions) do
    local start_row, start_col, end_row, end_col = ts.highlighter.region(bufnr, suggestion.left_variable)
    vim.api.nvim_buf_add_highlight(bufnr, highlight_namespace, 'WarningMsg', start_row, start_col, end_col)
  end
end

-- Function to update performance suggestions on buffer change
M.updatePerformanceSuggestions = function()
  local bufnr = vim.api.nvim_get_current_buf()
  local suggestions = M.findPerformanceSuggestions(bufnr)
  M.highlightPerformanceSuggestions(bufnr, suggestions)
end

-- Function to enable performance suggestions
function M.enable()
  vim.api.nvim_command('augroup PerformanceSuggestions')
  vim.api.nvim_command('autocmd!')
  vim.api.nvim_command('autocmd CursorHold,CursorHoldI <buffer> lua require("experiments.performance").updatePerformanceSuggestions()')
  vim.api.nvim_command('augroup END')
end

-- Function to disable performance suggestions
function M.disable()
  vim.api.nvim_command('augroup PerformanceSuggestions')
  vim.api.nvim_command('autocmd!')
  vim.api.nvim_command('augroup END')
end

-- Initialize plugin
function M.setup()
  M.enable()
end

return M
