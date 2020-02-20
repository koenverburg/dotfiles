" FZF
nnoremap <silent><leader>ff :FZF<cr>
inoremap <silent><leader>ff :FZF<cr>

" let g:fzf_layout = { 'window': 'call FloatingFZF()' }
" let $FZF_DEFAULT_OPTS .= '--color=bg:#20242C --border --layout=reverse'
" function! FloatingFZF() "   let width = float2nr(&columns * 0.9)
"   let height = float2nr(&lines * 0.6)
"   let opts = { 'relative': 'editor',
"       \ 'row': (&lines - height) / 2,
"       \ 'col': (&columns - width) / 2,
"       \ 'width': width,
"       \ 'height': height,
"       \ 'style': 'minimal'
"       \}

"   let win = nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
"   call setwinvar(win, '&winhighlight', 'NormalFloat:TabLine')
" endfunction