local M = {}
local core = require('core.config')
local utils = require("logic.utils")
local ts_utils = require('nvim-treesitter.ts_utils')

local parse_query = vim.treesitter.query.parse
local get_node_text = vim.treesitter.get_node_text or vim.treesitter.query.get_node_text

-- #region queries
local queries = {
  lua             = "(comment) @captures",
  javascript      = "(comment) @captures",
  typescript      = "(comment) @captures",
  reactjavascript = "(comment) @captures",
  reacttypescript = "(comment) @captures",
}
-- #endregion

-- #region local functions
local function enabled_when_supprted_filetype(bufnr)
  local filetype = vim.api.nvim_buf_get_option(bufnr, "ft")

  if utils.contains(core.supported_languages, filetype) then
    return true
  end

  return false
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
-- #endregion

function M.main()
  local bufnr = vim.api.nvim_get_current_buf()
  if not enabled_when_supprted_filetype(bufnr) then
    return
  end

  local _, parsed, root = query_buffer(bufnr, "(comment) @captures")
  if not parsed then
    return
  end

  local nodes_of_interest = {}
  for _, match in parsed:iter_matches(root, bufnr) do
    for _, node in pairs(match) do
      local text = get_node_text(node, bufnr)

      if string.find(text, '#region') then
        table.insert(nodes_of_interest, node)
      end

      if string.find(text, '#endregion') then
        table.insert(nodes_of_interest, node)
      end
    end
  end

  for i = 1, #nodes_of_interest, 2 do
    local pair = { nodes_of_interest[i], nodes_of_interest[i + 1] }

    local from = pair[1]
    local to = pair[2]

    vim.cmd(string.format("%s,%s fold", from:start() + 1, to:start() + 1))
  end
end

return M
