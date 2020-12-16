" This is for better vertial movement for wrapped lines
" Dont like wrapped lines but sometimes you have to wrapped it
nnoremap j gj
nnoremap k gk

" Faster moving from beginning to end of a line
nnoremap H ^
nnoremap L g_
vnoremap H ^
vnoremap L g_

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

nnoremap <leader>ev :vsp $MYVIMRC<cr>

" keep text selected after indentation
vnoremap < <gv
vnoremap > >gv

" Buffer management
" ~~~~~~~~~~~~~~~~~

" Buffer switching
nnoremap gt :bnext<CR>
nnoremap gT :bprevious<CR>
"nnoremap <tab> <C-w>l

"nnoremap <s-tab> <C-w>h
" New buffer
nnoremap <leader>bn :enew<cr>
" close buffer
nnoremap <leader>bq :bp <bar> bd! #<cr>
" close all buffers
nnoremap <leader>bQ :bufdo bd! #<cr>
" List buffers
nnoremap <silent> <space>b :<C-u>Buffers<cr>


" Execute this file, taken from TJ De Vries https://github.com/tjdevries/config_manager/blob/master/xdg_config/nvim/plugin/keymaps.vim
function! s:save_and_exec() abort
  if &filetype == 'vim'
    :silent! write
    :source %
  elseif &filetype == 'lua'
    :silent! write
    :luafile %
  endif

  return
endfunction

nnoremap <leader><leader>x :call <SID>save_and_exec()<CR>

" Remove whitespace
nnoremap <leader>sws :%s/\s\+$//<CR>

" Easier Moving between splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>


nnoremap <space>cs <cmd>:nohl <cr>
