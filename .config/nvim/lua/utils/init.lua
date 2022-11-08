local ts_utils = require "nvim-treesitter.ts_utils"
local M = {}

function M.bind(mode, keys, func)
  vim.api.nvim_set_keymap(mode, keys, func, { noremap = true, silent = true })
end

function M.normal(key, func)
  M.bind("n", key, func)
end

function M.visual(key, func)
  M.bind("v", key, func)
end

function M.insert(key, func)
  M.bind("i", key, func)
end

function M.terminal(key, func)
  M.bind("t", key, func)
end

function M.inputOrUI(opts, callback)
  opts = opts or { default = "", prompt = "prompt" }

  if not vim.ui.input then
    local value = vim.fn.input(opts.prompt .. ": ", opts.default)
    callback(value)
  else
    vim.ui.input(opts, callback)
  end
end

function M.PopUpSearch()
  local opts = {
    prompt = "Search For",
    default = "",
  }

  local proxy = function(value)
    if value == nil or value == "" then
      return
    end

    vim.cmd("/" .. value)
  end

  M.inputOrUI(opts, proxy)
end

function M.save_and_execute()
  local filetype = vim.bo.filetype

  if filetype == "vim" then
    vim.cmd [[silent! write]]
    vim.cmd [[source %]]
  elseif filetype == "lua" then
    vim.cmd [[silent! write]]
    vim.cmd [[luafile %]]
  end
end

local lsp_map = function(mode, key, action)
  local command = string.format("<cmd>lua %s()<cr>", action)
  vim.api.nvim_buf_set_keymap(0, mode, key, command, { noremap = true, silent = true })
end

function M.on_attach(client, bufnr)
  -- require("conrad.plugins.show-references").on_attach(client, bufnr)

  if client.name == "tsserver" or client.name == "gopls" then
    client.server_capabilities.document_formatting = false
  end

  if client.name == "tsserver" or client.name == "lua" or client.name == "go" then
    require("inlay-hints").on_attach(client, bufnr)
  end

  M.normal("<leader>lf", [[ <cmd>lua vim.lsp.buf.format({async=true})<cr> ]])
  M.normal('gp', "<cmd>lua require('peek').Peek('definition')<cr>")

  lsp_map("n", "K", "vim.lsp.buf.hover")
  lsp_map("n", "gD", "vim.lsp.buf.declaration")
  lsp_map("n", "gd", "vim.lsp.buf.definition")
  lsp_map("n", "<c-]>", "vim.lsp.buf.definition")
  lsp_map("n", "gi", "vim.lsp.buf.implementation")

  -- lsp saga
  lsp_map("n", "K", "require('lspsaga.hover').render_hover_doc")
  lsp_map("n", "gr", "require('lspsaga.rename').rename")

  lsp_map("n", "<leader>ca", "require('lspsaga.codeaction').code_action")
  lsp_map("i", "<leader>ca", "require('lspsaga.codeaction').code_action")

  lsp_map("n", "gx", "Lspsaga code_action<cr>")
  lsp_map("x", "gx", ":<c-u>Lspsaga range_code_action<cr>")

  -- Moved to telescope for these
  -- lsp_map('n', '<c-r>', 'vim.lsp.buf.references')
  -- lsp_map('n', 'gds', 'vim.lsp.buf.document_symbol')
  -- lsp_map('n', 'gW', 'vim.lsp.buf.workspace_symbol')

  lsp_map("n", "<leader>sd", "require('lspsaga.diagnostic').show_line_diagnostics")
  lsp_map("n", "[e", "require('lspsaga.diagnostic').lsp_jump_diagnostic_prev")
  lsp_map("n", "]e", "require('lspsaga.diagnostic').lsp_jump_diagnostic_next")
end

function M.is_empty(v)
  return v == nil or v == ""
end

function M.P(value)
  print(vim.inspect(value))
  return value
end

function M.setVirtualText(ns, line, text, prefix)
  local virtualText = string.format(" %s", text)

  if not M.is_empty(prefix) then
    virtualText = string.format(" %s %s", prefix, text)
  end

  vim.api.nvim_buf_set_virtual_text(0, ns, line, { { virtualText, "Comment" } }, {})
end

function M.contains(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end

function M.hideTablineWhenSingleTab()
  local total_tabs = vim.fn.tabpagenr "$"

  if total_tabs > 1 then
    vim.opt.showtabline = 2
  else
    vim.opt.showtabline = 0
  end
end

function M.dim(namespace, buffer, line_number)
  pcall(vim.api.nvim_buf_set_extmark, buffer, namespace, line_number, 0, {
    end_line = line_number + 1,
    end_col = 0,
    hl_group = "Comment", -- mvp
    hl_eol = true,
    priority = 10000,
  })
end

function M.loadable(name)
  local ok, module = pcall(require, name)

  if not ok then
    vim.notify("Failed to load " .. name)
    return
  end
  return module
end

function M.walk_tree(node, types)
  local expr = node

  while expr do
    if M.contains(types, expr:type()) then
      return expr
    end
    expr = expr:parent()
  end

  if not expr then return nil end
end

function M.walk_down(node, types)
  local expr = node
  local matches = {}

  while expr do
    if M.contains(types, expr:type()) then
      table.insert(matches, expr)
    end

    expr = expr:child()
  end

  if not expr then return nil end
end

function M.get_node(queries)
  local cursor_node = ts_utils.get_node_at_cursor()

  local node = M.walk_tree(cursor_node, queries)

  if node then return node end

  return nil
end

function M.get_query_matches(bufnr, query)
  local tree = vim.treesitter.get_parser(bufnr)

  if not tree then
    return nil
  end

  local ast = tree:parse()
  local root = ast[1]:root()

  local parsed = vim.treesitter.parse_query(tree:lang(), query)
  local results = parsed:iter_matches(root, bufnr)

  return results
end

return setmetatable({}, {
  __index = function(_, k)
    if M[k] then
      return M[k]
    else
      return require("utils")[k]
    end
  end,
})
