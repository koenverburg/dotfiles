local utils = require('conrad.utils')
local lspconfig = require('lspconfig')

vim.g.completion_confirm_key = ""
vim.g.completion_trigger_character = {'.'}
vim.g.completion_enable_auto_paren = 1 -- Complete parentheses for functions
vim.g.completion_trigger_keyword_length = 2
vim.g.completion_matching_strategy_list = {'exact', 'substring', 'fuzzy'}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    signs = true,
    underline = true,
    virtual_text = false,
    update_in_insert = false,
  }
)

-- lsp saga
vim.lsp.handlers["textDocument/hover"] = require('lspsaga.hover').handler

-- The langauges servers
local servers = {'vimls', 'tsserver', 'html', 'yamlls', 'graphql', 'terraformls'}

lspconfig.gopls.setup {
  on_attach = utils.on_attach,
}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = utils.on_attach,
  }
end

--require('nlua.lsp.nvim').setup(lspconfig, {
  --on_attach = on_attach,
--})

