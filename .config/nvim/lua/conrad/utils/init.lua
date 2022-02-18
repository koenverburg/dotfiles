local M = {}

function M.bind(mode, keys, func)
  vim.api.nvim_set_keymap(mode, keys, func, {noremap = true, silent = true})
end

function M.normal(key, func)
  M.bind('n', key, func)
end

function M.visual(key, func)
  M.bind('v', key, func)
end

function M.insert(key, func)
  M.bind('i', key, func)
end

function M.terminal(key, func)
  M.bind('t', key, func)
end

function M.save_and_execute()
  local filetype = vim.bo.filetype

  if filetype == 'vim' then
    vim.cmd [[silent! write]]
    vim.cmd [[source %]]
  elseif filetype == 'lua' then
    vim.cmd [[silent! write]]
    vim.cmd [[luafile %]]
  end
end

function M.telescope_map(key, f, options, buffer)
  local mode = 'n'
  local rhs = string.format(
    "<cmd>lua require('conrad.telescope')['%s'](%s)<CR>",
    f,
    options and vim.inspect(options, { newline = '' }) or ''
  )

  local options = {
    silent = true,
    noremap = true,
  }

  if not buffer then
    vim.api.nvim_set_keymap(mode, key, rhs, options)
  else
    vim.api.nvim_buf_set_keymap(0, mode, key, rhs, options)
  end
end

function lsp_map(mode, key, action)
  local command = string.format("<cmd>lua %s()<cr>", action)
  vim.api.nvim_buf_set_keymap(0, mode, key, command, {noremap=true, silent=true})
end

function M.on_attach(client)
  require('lsp_signature').on_attach()

  if client.name == "tsserver" or client.name == "gopls" then
    client.resolved_capabilities.document_formatting = false
  end

  lsp_map('n', 'K', 'vim.lsp.buf.hover')
  lsp_map('n', 'gD', 'vim.lsp.buf.declaration')
  lsp_map('n', 'gd', 'vim.lsp.buf.definition')
  lsp_map('n', '<c-]>', 'vim.lsp.buf.definition')
  lsp_map('n', 'gi', 'vim.lsp.buf.implementation')

  -- lsp saga
  lsp_map('n', 'K', "require('lspsaga.hover').render_hover_doc")
  lsp_map('n', 'gr', "require('lspsaga.rename').rename")

  lsp_map('n', '<leader>ca', "require('lspsaga.codeaction').code_action")
  lsp_map('i', '<leader>ca', "require('lspsaga.codeaction').code_action")

  lsp_map("n", "gx", "Lspsaga code_action<cr>")
  lsp_map("x", "gx", ":<c-u>Lspsaga range_code_action<cr>")

  -- Moved to telescope for these
  -- lsp_map('n', '<c-r>', 'vim.lsp.buf.references')
  -- lsp_map('n', 'gds', 'vim.lsp.buf.document_symbol')
  -- lsp_map('n', 'gW', 'vim.lsp.buf.workspace_symbol')

  lsp_map('n', '<leader>sd', "require('lspsaga.diagnostic').show_line_diagnostics")
  lsp_map('n', '[e', "require('lspsaga.diagnostic').lsp_jump_diagnostic_prev")
  lsp_map('n', ']e', "require('lspsaga.diagnostic').lsp_jump_diagnostic_next")
end

return setmetatable({}, {
  __index = function(_, k)

    if M[k] then
      return M[k]
    else
      return require('conrad.utils')[k]
    end
  end
})
