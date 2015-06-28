set nocompatible
filetype off

"git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
Plugin 'gmarik/Vundle.vim'

"Code environment
Plugin 'tpope/vim-rails'
Plugin 'moll/vim-node'
Plugin 'mattn/emmet-vim' " ctrl y RELEASE ,
    let g:user_emmet_install_global = 0
    autocmd FileType html,css,scss,stylus,jade EmmetInstall

"""""""""""""""""
"
" hightlight
"
"""""""""""""""""
Plugin 'altercation/vim-colors-solarized'
Plugin 'chriskempson/base16-vim'
Plugin 'ap/vim-css-color'

"""""""""""""""""
"
" CODE hightligh
"
"""""""""""""""""
Plugin 'sheerun/vim-polyglot'
"Plugin 'jelera/vim-javascript-syntax'
"Plugin 'digitaltoad/vim-jade'
"Plugin 'wavded/vim-stylus'
"Plugin 'kchmck/vim-coffee-script'
"Plugin 'vim-ruby/vim-ruby'
"Plugin 'tpope/vim-markdown'
"Plugin 'StanAngeloff/php.vim'
"Plugin 'octol/vim-cpp-enhanced-highlight'
"Plugin 'bps/vim-textobj-python'

"""""""""""""""""
"
" VIM INTERFACE
"
"""""""""""""""""
Plugin 'scrooloose/syntastic'
Plugin 'vim-scripts/matchit.zip'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'tpope/vim-commentary'
    "select with v and comment with gc
Plugin 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
    nnoremap <silent> <F4> :NERDTreeToggle<CR>
    nnoremap <silent> <F5> :NERDTreeFind<CR>
    "autocmd VimENter * NERDTree
    "autocmd VimENter * wincmd p
Plugin 'bling/vim-airline'
    let g:airline_theme='powerlineish'
    let g:airline#extensions#tabline#enabled = 1
    "let g:airline#extensions#tabline#left_alt_sep = '|'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'townk/vim-autoclose'
Plugin 'kien/ctrlp.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'wesQ3/vim-windowswap'
    let g:windowswap_map_keys = 0 "prevent default bindings
    nnoremap <silent> <leader>yw :call WindowSwap#MarkWindowSwap()<CR>
    nnoremap <silent> <leader>pw :call WindowSwap#DoWindowSwap()<CR>
    nnoremap <silent> <leader>ww :call WindowSwap#EasyWindowSwap()<CR>
Plugin 'zhaocai/GoldenView.Vim'
Plugin 'Yggdroot/indentLine'
    let g:indentLine_color_term = 239
    let g:indentLine_color_gui = '#A4E57E'

"""""""""""""""""
"
"snippets
"
"""""""""""""""""
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'sirver/ultisnips', { 'on': [] }
  let g:UltiSnipsSnippetsDir = '~/.vim/bundle/vim-snippets/UltiSnips'
  let g:UltiSnipsExpandTrigger="<c-j>"
  let g:UltiSnipsJumpForwardTrigger="<c-j>"
  let g:UltiSnipsJumpBackwardTrigger="<c-k>"
  let g:UltiSnipsListSnippets="<c-l>"

  inoremap <silent> <C-j> <C-r>=LoadUltiSnips()<cr>
  " This function only runs when UltiSnips is not loaded
  function! LoadUltiSnips()
    let l:curpos = getcurpos()
    execute plug#load('ultisnips')
    call cursor(l:curpos[1], l:curpos[2])
    call UltiSnips#ExpandSnippet()
    return ""
  endfunction

Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'

"""""""""""""""""
"
" autocomplete
"
"""""""""""""""""
Plugin 'myhere/vim-nodejs-complete'
Plugin 'shawncplus/phpcomplete.vim'




"""""""""""""""""
"
" plugins that are not needed
"
"""""""""""""""""
"Plugin 'junegunn/limelight.vim' nmap <Leader>l <Plug>(Limelight)



call vundle#end()



"""""""""""""""""
"
" setting stuff
"
"""""""""""""""""
set number
set tabstop=4
set shiftwidth=4
set expandtab
set splitright splitbelow
filetype plugin indent on
syntax on
colorscheme base16-paraiso
set background=dark
set encoding=utf-8
set laststatus=2
set lazyredraw
set hidden
set backspace=2
set backspace=indent,eol,start


"""""""""""""""""
"
" if gui
"
"""""""""""""""""
if has("gui_running")
  if has("gui_macvim")
    set guifont=Consolas:h15
  elseif has("gui_win32")
    set guifont=Consolas:h11
    set lines=35 columns=100
  endif
  set guioptions= " disable all UI options
  set guicursor+=a:blinkon0 " disable blinking cursor
  set ballooneval
  autocmd GUIEnter * set visualbell t_vb=
else
  set noerrorbells visualbell t_vb=
  if !s:is_nvim
    set term=xterm
  endif
  set t_ut= " setting for looking properly in tmux
  set t_ti= t_te= " prevent vim from clobbering the scrollback buffer
  let &t_Co = 256
  if s:is_windows " trick to support 256 colors and scroll in conemu
    let &t_AF="\e[38;5;%dm"
    let &t_AB="\e[48;5;%dm"
    inoremap <esc>[62~ <c-x><c-e>
    inoremap <esc>[63~ <c-x><c-y>
    nnoremap <esc>[62~ 3<c-e>
    nnoremap <esc>[63~ 3<c-y>
  endif
endif

"""""""""""""""""
"
" airline settings
"
"""""""""""""""""
function! AirlineInit()
    let g:airline_right_alt_sep = ''
    let g:airline_right_sep = ''
    let g:airline_left_alt_sep= ''
    let g:airline_left_sep = ''

    let g:airline_section_a = airline#section#create(['mode',' ','branch'])
    "let g:airline_section_b = airline#section#create_left(['ffenc','hunks ','%f'])
    let g:airline_section_c = airline#section#create(['filetype'])

    let g:airline_section_x = airline#section#create(['%P'])
    let g:airline_section_y = airline#section#create(['%B'])
    let g:airline_section_z = airline#section#create_right(['%l','%c'])
endfunction
autocmd VimEnter * call AirlineInit()

"Au BufWritePost .vimrc so ~/.vimrc
"Enable omni completion.
set omnifunc=syntaxcomplete#Complete
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType apache set commentstring=#\ %s



"""""""""""""""""
"
" Custom macro's
"
"""""""""""""""""

"nnoremap <silent> <F11> :simalt ~x<CR>
"autocmd VimEnter * vsp


"""""""""""""""""
"
" better backup, swap and undo storage
"
"""""""""""""""""
set noswapfile
set backup
set undofile

set backupdir=~/.vim/dirs/backup
set undodir=~/.vim/dirs/undo
if !isdirectory(&backupdir)
  call mkdir(&backupdir, "p")
endif
if !isdirectory(&undodir)
  call mkdir(&undodir, "p")
endif
