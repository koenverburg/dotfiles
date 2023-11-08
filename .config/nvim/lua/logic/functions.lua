local core = require("core.config")

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
    -- require("persistence").save()
    vim.cmd(":qall")
  end)
end

function M.save_and_execute()
  print("save and execute")
  local filetype = vim.bo.filetype

  if filetype == "vim" then
    vim.cmd([[silent! write]])
    vim.cmd([[source %]])
  elseif filetype == "lua" then
    vim.cmd([[silent! write]])
    vim.cmd([[luafile %]])
  end
end

local function hide_tabline()
  local total_tabs = vim.fn.tabpagenr("$")

  if total_tabs > 1 then
    vim.opt.showtabline = 2
  else
    vim.opt.showtabline = 0
  end
end

function M.hideTablineWhenSingleTab()
  hide_tabline()
  vim.api.nvim_create_autocmd({
    "BufWinEnter",
    "BufEnter",
    "BufWritePost",
    "TabNew",
    "TabClosed",
  }, { callback = hide_tabline })
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
  if client.name == "tsserver" or client.name == "sumneko_lua" or client.name == "gopls" then
    -- vim.lsp.inlay_hint(bufnr, true)
    client.server_capabilities.document_formatting = false
  end

  if M.is_enabled('nvim-navbuddy') then
    local navbuddy = require("nvim-navbuddy")
    navbuddy.attach(client, bufnr)
  end

  -- if client.name == "rome" then
  --   client.server_capabilities.document_formatting = true
  -- end

  -- local ih = require("inlay-hints")
  -- if ih then
  --   ih.on_attach(client, bufnr)
  -- end

  require("lsp_signature").on_attach({
    bind = true,
    handler_opts = {
      border = "rounded",
    },
  }, bufnr)

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

function M.createSession()
  local input = {
    prompt = "Session name ",
    default = "",
  }

  M.inputOrUI(input, function(value)
    print(value)
    print("hii")
    -- vim.cmd("set modifiable")
    -- vim.cmd("<cmd>PossessionSave " .. value .. "<cr>")
  end)
end

function M.createTerminal(cmd)
  local Terminal = require("toggleterm.terminal").Terminal
  local window = Terminal:new({
    cmd = cmd or "zsh",
    dir = "git_dir",
    direction = "float",
    float_opts = {
      border = "double",
    },
    -- function to run on opening the terminal
    on_open = function(term)
      vim.cmd("startinsert!")
      vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
    end,
    -- function to run on closing the terminal
    on_close = function(term)
      vim.cmd("startinsert!")
    end,
  })
  window:toggle()
end

return M
