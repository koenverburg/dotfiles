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

local on_attach = function(client, bufnr)
  require('completion').on_attach(client, bufnr)
  local opts = { noremap=true, silent=true }

  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD',  '<Cmd>lua vim.lsp.buf.declaration()<CR>'     , opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd',  '<Cmd>lua vim.lsp.buf.definition()<CR>'      , opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi',  '<cmd>lua vim.lsp.buf.implementation()<CR>'  , opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr',  '<cmd>lua vim.lsp.buf.references()<CR>'      , opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gx',  '<cmd>lua vim.lsp.buf.code_action()<CR>'     , opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gds', '<cmd>lua vim.lsp.buf.document_symbol()<CR>' , opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gws', '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>', opts)

  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>sh', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)

  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>xr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>xd', '<cmd>lua vim.lsp.util.show_line_diagnostics()<CR>', opts)
  --buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  --buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  --buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  --buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  --buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  --buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  --buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  --buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  --buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  --buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  --buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  --buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  --buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  --buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  --buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
end

-- The langauges servers
local servers = {'vimls', 'tsserver', 'html', 'gopls', 'yamlls'}
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
  }
end
