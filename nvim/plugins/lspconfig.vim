let g:diagnostic_insert_delay = 1
let g:diagnostic_show_sign = 1
let g:diagnostic_enable_virtual_text = 1
let g:diagnostic_enable_ale = 0
" Complete parentheses for functions
let g:completion_enable_auto_paren = 1
" Work with vim-endwise
let g:completion_confirm_key = "\<C-y>"
" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect
" Avoid showing message extra message when using completion
set shortmess+=c

"let g:completion_enable_snippet = 'UltiSnips'
"
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
let g:completion_trigger_character = ['.']

:lua <<EOF
  local nvim_lsp = require('lspconfig')

  local lsp_status = require('lsp-status')
  lsp_status.register_progress()
  lsp_status.config({
    status_symbol = '',
    indicator_ok = 'ok',
    indicator_info = 'i',
    indicator_hint = 'h',
    indicator_errors = 'e',
    indicator_warnings = 'w'
  })

  local on_attach = function(client, bufnr)
    require('diagnostic').on_attach(client, bufnr)
    require('completion').on_attach(client, bufnr)
    require('lsp-status').on_attach(client, bufnr)

    local opts = { noremap=true, silent=true }

    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gds', '<cmd>lua vim.lsp.buf.document_symbol()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gws', '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gc', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)

    -- this will format using the server
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>=', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>sh', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)

    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>xr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>xd', '<cmd>lua vim.lsp.util.show_line_diagnostics()<CR>', opts)
  end

  local servers = {'vimls', 'tsserver', 'html', 'gopls', 'yamlls'}

  for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
      on_attach = on_attach,
      capabilities = lsp_status.capabilities
    }
  end
EOF

" vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>xD', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
" Use `[d` and `]d` for navigate diagnostics
"nnoremap <silent> ]d :NextDiagnostic<CR>
"nnoremap <silent> [d :PrevDiagnostic<CR>
"nnoremap <silent> <leader>do :OpenDiagnostic<CR>
