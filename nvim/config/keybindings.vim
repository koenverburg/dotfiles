" This is for etter vertial movement for wrapped lines
" Dont like wrapped lines but sometimes you have to wrapped it
nnoremap j gj
nnoremap k gk

" Faster moving from beginning to end of a line
nnoremap H ^
nnoremap L g_

" Jumping from the beginning of a []{}() to the end
nnoremap <Tab> %

"Keep search matches in the middle of the window
nnoremap n nzzzv
nnoremap N Nzzzv

" Searching
nnoremap / /\v
vnoremap / /\v

" Quickly return to normal mode
inoremap jj <esc>

" Swap : and ; to make colon commands easer to type
nnoremap ; :
nnoremap : ;

" oplit pane switching
" using ctrl + {h,j,k,l}
tnoremap <C-h> <C-\><C-N><C-w>h
tnoremap <C-j> <C-\><C-N><C-w>j
tnoremap <C-k> <C-\><C-N><C-w>k
tnoremap <C-l> <C-\><C-N><C-w>l
inoremap <C-h> <C-\><C-N><C-w>h
inoremap <C-j> <C-\><C-N><C-w>j
inoremap <C-k> <C-\><C-N><C-w>k
inoremap <C-l> <C-\><C-N><C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Tab Switching (shift+{t,h,l}
nnoremap <leader><S-t> :tabnew<cr>
nnoremap <leader><S-h> :tabprev<cr>
nnoremap <leader><S-l> :tabnext<cr>

" window resizing
nnoremap <c-left> 5<c-w>>
nnoremap <c-right> 5<c-w><

" Faster saving
inoremap <leader>w :w<cr>
nnoremap <leader>w :w<cr>

" quickly cancel search highlighting
nnoremap <leader><space> :nohlsearch<cr>

" Credo wants this, sort aliases in alphabetical order
vnoremap <leader>s :'<,'>!sort -f<cr>

" Quickly insert a timestamp
nnoremap tt "=strftime("%F %T%z")<CR>p

" Toggle quickfix window
nnoremap <leader><leader> :call ToggleQuickfix()<cr>
function! ToggleQuickfix()
  for buffer in tabpagebuflist()
    if bufname(buffer) == ''
      " then it should be the quickfix window
      cclose
      return
    endif
  endfor

  copen
endfunction