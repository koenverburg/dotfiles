" Set completeopt to have a better completion experience
"set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
"set shortmess+=c

" let g:completion_enable_auto_popup = 1 " Disable it by default
let g:completion_trigger_character = ['.']

" Use `[d` and `]d` for navigate diagnostics
nnoremap <silent> ]d :NextDiagnostic<CR>
nnoremap <silent> [d :PrevDiagnostic<CR>
nnoremap <silent> <leader>do :OpenDiagnostic<CR>

"let g:completion_confirm_key = "\<C-y>"
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

:lua <<EOF
  local nvim_lsp = require('lspconfig')

  local on_attach = function(_, bufnr)
    require('diagnostic').on_attach()
    require('completion').on_attach()
    local opts = { noremap=true, silent=true }
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)

    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>l', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ds', '<cmd>lua vim.lsp.buf.document_symbol()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ws', '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>', opts)

    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>sh', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>xa', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)

    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>xr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>xd', '<cmd>lua vim.lsp.util.show_line_diagnostics()<CR>', opts)
  end

  local servers = {'vimls', 'tsserver', 'html', 'gopls', 'yamlls'}
  for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
      on_attach = on_attach,
    }
  end
EOF

" vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>xD', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)

"command! -buffer -nargs=0 LspShowLineDiagnostics lua require'jumpLoc'.openLineDiagnostics()
"nnoremap <buffer><silent> <C-h> <cmd>LspShowLineDiagnostics<CR>
"command! Format execute 'lua vim.lsp.buf.formatting()'
