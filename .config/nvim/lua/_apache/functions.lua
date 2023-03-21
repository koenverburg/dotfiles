local core = require('_apache.core')

local M = {}

function M.is_enabled(plugin)
	return core.plugins[plugin].enabled
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

function M.quite()
  vim.schedule(function()
    -- require("experiments.gc").clean()
    -- vim.cmd "tabdo SymbolsOutlineClose"
    require("persistence").save()
    vim.cmd(":qall")
  end)
end

function M.save_and_execute()
  print("save and execute")
  local filetype = vim.bo.filetype

  if filetype == "vim" then
    vim.cmd [[silent! write]]
    vim.cmd [[source %]]
  elseif filetype == "lua" then
    vim.cmd [[silent! write]]
    vim.cmd [[luafile %]]
  end
end

function M.hideTablineWhenSingleTab()
  local events = { "TabClosed" }

  vim.api.nvim_create_autocmd(events, { callback = function()
    local total_tabs = vim.fn.tabpagenr "$"

    if total_tabs > 1 then
      vim.opt.showtabline = 2
    else
      vim.opt.showtabline = 0
    end
  end})
end

function M.bind(mode, keys, func)
  vim.keymap.set(mode, keys, func, { noremap = true, silent = true })
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

function M.telescope_map(key, func)
  M.bind("n", key, func)
end

local lsp_map = function(mode, key, action)
  local command = string.format("<cmd>lua %s()<cr>", action)
  vim.api.nvim_buf_set_keymap(0, mode, key, command, { noremap = true, silent = true })
end

function M.on_attach(client, bufnr)
  -- require("experiments.show-references").on_attach(client, bufnr)

  if client.name == "tsserver" or client.name == "sumneko_lua" or client.name == "gopls" then
    client.server_capabilities.document_formatting = false
  end

  -- if client.name == "tsserver" or client.name == "sumneko_lua" or client.name == "gopls" then
  --   require("inlay-hints").on_attach(client, bufnr)
  -- end

  -- if client.server_capabilities.documentSymbolProvider then
  --   require("nvim-navic").attach(client, bufnr)
  -- end

  M.bind("n", "<leader>lf", [[ <cmd>lua vim.lsp.buf.format({async=true})<cr> ]])

  lsp_map("n", "K", "vim.lsp.buf.hover")
  lsp_map("n", "gD", "vim.lsp.buf.declaration")
  lsp_map("n", "gd", "vim.lsp.buf.definition")
  lsp_map("n", "<c-]>", "vim.lsp.buf.definition")
  lsp_map("n", "gi", "vim.lsp.buf.implementation")
  lsp_map("n", "goc", "vim.lsp.buf.outgoing_calls")

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

return M
