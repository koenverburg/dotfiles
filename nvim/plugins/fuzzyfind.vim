" FZF
let g:fzf_layout = {'up':'~90%', 'window': { 'width': 0.8, 'height': 0.8,'yoffset':0.5,'xoffset': 0.5, 'highlight': 'Todo', 'border': 'sharp' } }

let $FZF_DEFAULT_COMMAND="rg --files --hidden"
let $FZF_DEFAULT_OPTS = '--layout=reverse --info=inline'

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }


if executable('fzf')
  nnoremap <leader>t :FZF<cr>
endif

" Find in files
if executable('rg')
  let g:ackprg = 'rg --vimgrep'
  nnoremap <leader>ff :Rg
  nnoremap <leader><s-b> :Buffers<CR>
  " nnoremap <leader><s-b> :Buffers<CR>
  " nnoremap <leader><s-b> :Buffers<CR>
endif