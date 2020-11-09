let g:completion_confirm_key = "\<C-y>"
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

:lua << EOF
  local nvim_lsp = require('nvim_lsp')
  local on_attach = function(_, bufnr)
    require('diagnostic').on_attach()
    require('completion').on_attach()
    local opts = { noremap=true, silent=true }
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>xD', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>xr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>xd', '<cmd>lua vim.lsp.util.show_line_diagnostics()<CR>', opts)
  end
  local servers = {'jsonls', 'vimls', 'tsserver', 'cssls', 'html'}
  for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
      on_attach = on_attach,
    }
  end
EOF

command! -buffer -nargs=0 LspShowLineDiagnostics lua require'jumpLoc'.openLineDiagnostics()
nnoremap <buffer><silent> <C-h> <cmd>LspShowLineDiagnostics<CR>
command! Format execute 'lua vim.lsp.buf.formatting()'

:lua << EOF
  require'nvim-treesitter.configs'.setup {
    ensure_installed = "maintained",
    highlight = {
      enable = true,
      disable = { },
    },
  }
EOF

" function! xstl#lsp() abort
"   let sl = ''
"   if luaeval('not vim.tbl_isempty(vim.lsp.buf_get_clients(0))')
"     let sl .= ' %{luaeval("vim.lsp.util.buf_diagnostics_count([[Error]])")} '
"     let sl .= ' %{luaeval("vim.lsp.util.buf_diagnostics_count([[Warning]])")}'
"   else
"     let sl .= ''
"   endif
"   return sl
" endfunction

" let g:mode_dict = { 'n': '', 'no': '', 'nov': '', 'noV': '', "no\<C-v>": '', 'niI': '', 'niR': '', 'niV': '', 'v': '',
"       \ 'V': '', "\<C-v>": '', 's': '', 'S': '', "\<C-s>": '', 'i': '', 'ic': '', 'ix': '', 'R': 'ﰉ', 'Rc': 'ﰉ', 'Rv': 'ﰉ',
"       \ 'Rx': 'ﰉ', 'c': 'ﱕ', 'cv': 'ﱕ', 'ce': 'ﱕ', 'r': '', 'rm': '', 'r?': '', '!': '', 't': '', 'unknown': '', }

" function xstl#cft() abort
"   return &ft !=# '' ? &ft : ''
" endfunction

" function xstl#icon() abort
"   return get(g:mode_dict, mode(1), g:mode_dict.unknown)
" endfunction

" function xstl#mod() abort
"   return &mod ? '  ' : ''
" endfunction

" function xstl#file() abort
"   return expand('%:t') ==# '' ? '' : expand('%:t')
" endfunction

" function xstl#astl() abort
"   let &l:stl = '%#Normal# %#Directory#%#Search#%{xstl#icon()}%#Directory# %#MoreMsg#%#IncSearch#%{xstl#file()}%{xstl#mod()}%#MoreMsg#%#Normal#%=%#Title#%#TablineSel#%{xstl#cft()}%#Title# %#Red#%#debugBreakpoint#' . xstl#lsp() . '%#Red#%#Normal# '
" endfunction

" function xstl#istl() abort
"   let &l:stl = '%#Normal# %#VertSplit#%#MatchParen#%{xstl#icon()}%#VertSplit# %#VertSplit#%#MatchParen#%{xstl#file()}%{xstl#mod()}%#VertSplit#%#VertSplit#%=%#VertSplit#%#MatchParen#%{xstl#cft()}%#VertSplit# %#VertSplit#%#MatchParen#' . xstl#lsp() . '%#VertSplit#%#VertSplit# '
" endfunction

" aug St
"   au!
"   au WinEnter,BufEnter * call xstl#astl()
"   au User LspDiagnosticsChanged call xstl#astl()
"   au WinLeave,BufLeave * call xstl#istl()
" aug END