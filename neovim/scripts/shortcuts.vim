
" open a new tab
nnoremap <c-t> :tabnew<cr>

" sudo write
command! W :w !sudo tee %

" Tabs
nnoremap <A>h :tabprev<cr>
nnoremap <A>l :tabnext<cr>

" Keep search matches in the middle of the window.
nnoremap n nzzzv
nnoremap N Nzzzv

" quick scape to get out of hlsearch
nnoremap <leader><space> :nohlsearch<cr>

" Same when jumping around
nnoremap g; g;zz
nnoremap g, g,zz
noremap <c-o> <c-o>zz

" move faster from the begin of the line to the end of the line
noremap H ^
noremap L g_
nnoremap <Tab> %

" emulate windows copy, cut behavior
noremap <LeftRelease> "+y<LeftRelease>
noremap <C-c> "+y<CR>
noremap <C-x> "+d<CR>

" switch between splits using ctrl + {h,j,k,l}
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

" select text via ctrl+shift+arrows in insert mode
inoremap <C-S-left> <esc>vb
inoremap <C-S-right> <esc>ve

" faster saving
nnoremap <leader>w :w<cr>
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<cr>

" Save when losing focus
au FocusLost * :wa

" window resizing
nnoremap <c-left> 5<c-w>>
nnoremap <c-right> 5<c-w><

" Select (charwise) the content of the current line, excluding indentation
nnoremap VV ^vg_

" insert mode completion
inoremap <c-l> <c-x><c-l>
inoremap <c-f> <c-x><c-f>

" Quick edit vimrc
nnoremap <leader>ev :vsp  $localappdata/nvim/init.vim<cr>

"easy ecape w/ modding my keyboard
inoremap jj <esc>

" swap : and ; to make colon commands easer to type
nnoremap ; :
nnoremap : ;

set colorcolumn=81
hi ColorColumn ctermbg=green
call matchadd('ColorColumn', '\%81v', 100)

" moving the tabs
nnoremap <silent> <A-Left> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> <A-Right> :execute 'silent! tabmove ' . tabpagenr()<CR>

function! Rotate() " switch between horizontal and vertical split mode for open splits
  " save the original position, jump to the first window
  let initial = winnr()
  exe 1 . "wincmd w"

  wincmd l
  if winnr() != 1
    " succeeded moving to the right window
    wincmd J                " make it the bot window
  else
    " cannot move to the right, so we are at the top
    wincmd H                " make it the left window
  endif
  " restore cursor to the initial window
  exe initial . "wincmd w"
endfunction

nnoremap <F6> :call Rotate()<CR>

function! MyFoldText() " {{{
    let line = getline(v:foldstart)
    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart

    " expand tabs into spaces
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')

    let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
    " let fillcharcount = windowwidth - len(line) - len(foldedlinecount) - len('lines')
    " let fillcharcount = windowwidth - len(line) - len(foldedlinecount) - len('lines   ')
    let fillcharcount = windowwidth - len(line)
    " return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . ' Lines'
    return line . '⋯'. repeat(" ",fillcharcount)
endfunction " }}}

set foldtext=MyFoldText()

autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif

" autocmd FileType vim setlocal fdc=1
set foldlevel=99

" Space to toggle folds.
nnoremap <Space> za
vnoremap <Space> za
autocmd FileType vim setlocal foldmethod=marker
autocmd FileType vim setlocal foldlevel=0

autocmd FileType javascript,html,css,scss,python setlocal foldlevel=99

autocmd FileType css,scss,json setlocal foldmethod=marker
autocmd FileType css,scss,json setlocal foldmarker={,}

let g:xml_syntax_folding = 1
autocmd FileType xml setl foldmethod=syntax

autocmd FileType html setl foldmethod=expr
autocmd FileType html setl foldexpr=HTMLFolds()

autocmd FileType javascript,json setl foldmethod=syntax

" Testing
" nmap <silent> t<C-n> :TestNearest<CR>
" nmap <silent> t<C-f> :TestFile<CR>
" nmap <silent> t<C-s> :TestSuite<CR>
" nmap <silent> t<C-l> :TestLast<CR>
" nmap <silent> t<C-g> :TestVisit<CR>

" nnoremap <Leader>yt :vsplit<CR>:term yarn test<CR>
function! SplitStrategy(cmd)
  botright new | call termopen(a:cmd) | startinsert
endfunction

let g:test#custom_strategies = {'terminal_split': function('SplitStrategy')}
let g:test#strategy = 'terminal_split'

" NerdTree

let g:NERDTreeIgnore = ['^node_modules$']
let NERDTreeShowHidden = 1
let NERDTreeShowLineNumbers = 0

nnoremap <silent><leader>nn :NERDTreeToggle<cr>
inoremap <silent><leader>nn :NERDTreeToggle<cr>
let g:indentLine_fileTypeExclude = ["nerdtree"]
