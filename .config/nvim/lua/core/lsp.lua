vim.g.diagnostic_show_sign = 1
vim.g.diagnostic_enable_ale = 0
vim.g.diagnostic_insert_delay = 0
vim.g.diagnostic_enable_virtual_text = 1

vim.g.completion_confirm_key = ""
vim.g.completion_trigger_character = {'.'}
vim.g.completion_enable_auto_paren = 1 -- Complete parentheses for functions
vim.g.completion_trigger_keyword_length = 2
vim.g.completion_matching_strategy_list = {'exact', 'substring', 'fuzzy'}

local nvim_lsp = require('lspconfig')
local lsp_status = require('lsp-status')
lsp_status.register_progress()

lsp_status.config({
  indicator_errors = 'E',
  indicator_warnings = 'W',
  indicator_info = 'i',
  indicator_hint = '?',
  indicator_ok = 'Ok',
})

local mapper = function(mode, key, command)
  vim.api.nvim_buf_set_keymap(0, mode, key, command, {noremap=true, silent=true})
end

local on_attach = function(client)
  require('completion').on_attach(client)
  lsp_status.on_attach(client)

  mapper('n', 'gD',  '<cmd>lua vim.lsp.buf.declaration()<CR>')
  mapper('n', 'gd',  '<cmd>lua vim.lsp.buf.definition()<CR>')
  mapper('n', '<c-]>',  '<cmd>lua vim.lsp.buf.definition()<CR>')

  mapper('n', 'gi',  '<cmd>lua vim.lsp.buf.implementation()<CR>')
  mapper('n', 'gr',  '<cmd>lua vim.lsp.buf.references()<CR>')
  mapper('n', 'gx',  '<cmd>lua vim.lsp.buf.code_action()<CR>')

  mapper('n', 'gds', '<cmd>lua vim.lsp.buf.document_symbol()<CR>')
  mapper('n', 'gW', '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>')

  mapper('n', 'gk', '<Cmd>lua vim.lsp.buf.hover()<CR>')
  mapper('i', '<c-s>', '<cmd>lua vim.lsp.buf.signature_help()<cr>')
  mapper('n', '<s-n>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')

  mapper('n', '<leader>rd', '<cmd>lua vim.lsp.buf.rename()<CR>')
  mapper('n', '<leader>sd', '<cmd>lua vim.lsp.util.show_line_diagnostics()<CR>')
end

-- The langauges servers
-- TODO add lua if unix
local servers = {'vimls', 'tsserver', 'html', 'yamlls', 'terraformls', 'gopls'}
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    capabilities = lsp_status.capabilities
  }
end

--local codelens_capabilities = vim.lsp.protocol.make_client_capabilities()
--codelens_capabilities.textDocument.codeLens = {
  --dynamicRegistration = false,
--}

--nvim_lsp.gopls.setup {
  --on_attach = on_attach,
  --capabilities = codelens_capabilities,

  --settings = {
    --gopls = {
      --codelenses = { test = true },
    --}
  --}
--}


-- CodeLens
--vim.lsp.handlers["textDocument/codeLens"] = function(err, _, result)
  --print("Code Lens...")
  --P(result)
  --print("...Code Lens")
--end
