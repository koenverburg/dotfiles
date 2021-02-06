vim.g.diagnostic_insert_delay = 1
vim.g.diagnostic_show_sign = 1
vim.g.diagnostic_enable_ale = 0
vim.g.diagnostic_enable_virtual_text = 1
vim.g.completion_enable_auto_paren = 1 -- Complete parentheses for functions
--vim.g.completion_enable_snippet = 'UltiSnips'
vim.g.completion_confirm_key = "\\<C-y>"
vim.g.completion_matching_strategy_list = { 'exact', 'substring', 'fuzzy' }
vim.g.completion_trigger_character = '.'

local nvim_lsp = require('lspconfig')

local mapper = function(mode, key, command)
  vim.api.nvim_buf_set_keymap(0, mode, key, command, { noremap=true, silent=true })
end

local on_attach = function(client)
  require('completion').on_attach(client)

  mapper('n', 'gD',  '<cmd>lua vim.lsp.buf.declaration()<CR>')
  mapper('n', 'gd',  '<cmd>lua vim.lsp.buf.definition()<CR>')
  mapper('n', '<c-]>',  '<cmd>lua vim.lsp.buf.definition()<CR>')

  mapper('n', 'gi',  '<cmd>lua vim.lsp.buf.implementation()<CR>')
  mapper('n', 'gr',  '<cmd>lua vim.lsp.buf.references()<CR>')
  mapper('n', 'gx',  '<cmd>lua vim.lsp.buf.code_action()<CR>')

  mapper('n', 'gds', '<cmd>lua vim.lsp.buf.document_symbol()<CR>')
  mapper('n', 'gW', '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>')

  mapper('n', 'H', '<Cmd>lua vim.lsp.buf.hover()<CR>')
  --mapper('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>')

  mapper('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
  mapper('n', '<c-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')

  mapper('n', '<leader>rd', '<cmd>lua vim.lsp.buf.rename()<CR>')
  mapper('n', '<leader>sd', '<cmd>lua vim.lsp.util.show_line_diagnostics()<CR>')
end

-- The langauges servers
-- TODO add terraformls + lua if unix
local servers = {'vimls', 'tsserver', 'html', 'gopls', 'yamlls'}
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
  }
end