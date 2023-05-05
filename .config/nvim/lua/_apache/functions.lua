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

local function hide_tabline()
  local total_tabs = vim.fn.tabpagenr "$"

  if total_tabs > 1 then
    vim.opt.showtabline = 2
  else
    vim.opt.showtabline = 0
  end
end

function M.hideTablineWhenSingleTab()
  hide_tabline()
  vim.api.nvim_create_autocmd({ "TabClosed", "TabNew", "BufDelete", "WinNew" }, { callback = hide_tabline })
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
  local static_info = require('experiments.static-info')

  if static_info.enabled_when_supprted_filetype(bufnr) then
    -- trigger once
    -- static_info.show_reference()
    static_info.show_early_exit()
    static_info.show_named_imports()
    static_info.show_default_exports()

    -- trigger when buffer changes
    static_info.autocmd()
  end

  if client.name == "tsserver" or client.name == "sumneko_lua" or client.name == "gopls" then
    client.server_capabilities.document_formatting = false
  end

  require "lsp_signature".on_attach({
    bind = true,
    handler_opts = {
      border = "rounded"
    }
  }, bufnr)

  -- if client.name == "tsserver" or client.name == "sumneko_lua" or client.name == "gopls" then
  --   require("inlay-hints").on_attach(client, bufnr)
  -- end

  -- if client.server_capabilities.documentSymbolProvider then
  --   require("nvim-navic").attach(client, bufnr)
  -- end

  M.bind("n", "<leader>lf", [[ <cmd>lua vim.lsp.buf.format({async=true})<cr> ]])

  lsp_map("n", "<leader>sd", "vim.diagnostic.open_float")
  lsp_map("n", "K", "vim.lsp.buf.hover")
  -- lsp_map('n', '<C-K>', "vim.lsp.buf.signature_help")
  lsp_map("n", "gD", "vim.lsp.buf.declaration")
  lsp_map("n", "gd", "vim.lsp.buf.definition")
  lsp_map("n", "<c-]>", "vim.lsp.buf.definition")
  lsp_map("n", "gi", "vim.lsp.buf.implementation")
  lsp_map("n", "goc", "vim.lsp.buf.outgoing_calls")

  lsp_map("n", "<leader>ca", "vim.lsp.buf.code_action")
  lsp_map("i", "<leader>ca", "vim.lsp.buf.code_action")
end

return M
