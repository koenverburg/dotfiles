" .vimrc
" Author: CreativeKoen <creativekoen@gmail.com>
" Source: https://github.com/CreativeKoen/dotfiles

" getting started ---------------------------------------------------- {{{

" clone vundle first then run vim or gvim and use the command PluginInstall
" to install all the plugins, and restart after that is done.
" git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

" }}}
" vundle  ------------------------------------------------------------ {{{

let s:is_windows = has('win32') || has('win32')
let s:is_nvim = has('nvim')

set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
    Plugin 'gmarik/Vundle.vim'
"Code environment
    "Plugin 'moll/vim-node'
    Plugin 'mattn/emmet-vim' " ctrl y RELEASE ,
" hightlight
    Plugin 'altercation/vim-colors-solarized'
    Plugin 'chriskempson/base16-vim'
    Plugin 'ap/vim-css-color'                   " see what the hex color is
    Plugin 'sheerun/vim-polyglot'               " support a whole lot of filetypes
    Plugin 'xsbeats/vim-blade'                  " support for blade (laravel)
    Plugin 'mxw/vim-jsx'                        " support for jsx with reactjs
    Plugin 'digitaltoad/vim-pug'                " pug(jade) syntax support
" VIM INTERFACE
    Plugin 'scrooloose/syntastic'               "error checking
    Plugin 'pmsorhaindo/syntastic-local-eslint.vim' "Linting for Nodejs projects
    "Plugin 'vim-scripts/matchit.zip'
    Plugin 'editorconfig/editorconfig-vim'
    Plugin 'terryma/vim-multiple-cursors'
    "Plugin 'Lokaltog/vim-easymotion'
    Plugin 'scrooloose/nerdtree'
    Plugin 'vim-airline/vim-airline'
    Plugin 'vim-airline/vim-airline-themes'
    Plugin 'tpope/vim-commentary'               "select with v and comment with //gc
    Plugin 'tpope/vim-fugitive'                 "git from vim
    Plugin 'tpope/vim-surround'
    Plugin 'townk/vim-autoclose'
    Plugin 'kien/ctrlp.vim'
    Plugin 'airblade/vim-gitgutter'
    Plugin 'Yggdroot/indentLine'
    Plugin 'xolox/vim-session'
    Plugin 'xolox/vim-misc'
"snippets
    Plugin 'sirver/ultisnips'
    Plugin 'garbas/vim-snipmate'
    Plugin 'honza/vim-snippets'
" utilies
    Plugin 'MarcWeber/vim-addon-mw-utils'
    Plugin 'tomtom/tlib_vim'
    Plugin 'junegunn/limelight.vim'
" autocomplete
    " autocomplete libs
    Plugin 'myhere/vim-nodejs-complete'
    Plugin 'shawncplus/phpcomplete.vim'
    Plugin 'artur-shaik/vim-javacomplete2'  "http://vimawesome.com/plugin/vim-javacomplete2 when using java
    "autocomplete driver
    Plugin 'ervandew/supertab'
    Plugin 'shougo/neocomplcache.vim'
    "Plugin 'm2mdas/phpcomplete-extended-laravel'
    "Plugin 'arnaud-lb/vim-php-namespace'
call vundle#end()
" }}}
" after vundle  ------------------------------------------------------ {{{
filetype plugin indent on
syntax on

"colorscheme solarized
colorscheme base16-monokai
set background=dark
set fileformat=unix
set fileformats=unix,dos
" }}}
" Basic options ------------------------------------------------------ {{{
set ignorecase
set smartcase

set number
set hlsearch
set encoding=utf-8
set laststatus=2
set showtabline=2
set lazyredraw
set hidden
set noshowmode

" Leader
let mapleader = ","
let maplocalleader = "\\"

"let me paste from system clipboard
set clipboard+=unnamed

" utf-8 {{{
if has("multi_byte")
  if &termencoding == ""
    let &termencoding = &encoding
  endif
  set encoding=utf-8
  setglobal fileencoding=utf-8
  "setglobal bomb
  set fileencodings=ucs-bom,utf-8,latin1
endif
" }}}
" make backspace work in insert mode {{{
set backspace=2
set backspace=indent,eol,start
set scrolloff=15
" }}}
" backup ----------------------------------------------------------- {{{
set backup
set undofile
set backupdir=~/.vim/temp/backup//
set undodir=~/.vim/temp/undo//
set directory=~/.vim/temp/swap//
" lets make those folder it they don't already exist.
if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
    call mkdir(expand(&directory), "p")
endif
" }}}
" folding ----------------------------------------------------------- {{{
set foldlevelstart=0
set foldmethod=marker

" Space to toggle folds.
nnoremap <Space> za
vnoremap <Space> za
autocmd FileType vim,c++,js,scss,html,jade,php setlocal foldmethod=marker

nnoremap z0 zCz

nnoremap <leader>z zMzvvz

function! MyFoldText() " {{{
    let line = getline(v:foldstart)

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart

    " expand tabs into spaces
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')

    let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
    return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '
endfunction " }}}
set foldtext=MyFoldText()

" }}}

" }}}
" make vim work in conemu -------------------------------------------- {{{
set notimeout
set ttimeout
set ttimeoutlen=10
set synmaxcol=800
" }}}
" plugin setting ----------------------------------------------------- {{{

" Default mapping multi cursors
let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'
let g:multi_cursor_use_default_mapping=0

let g:UltiSnipsSnippetsDir = '~/.vim/bundle/vim-snippets/UltiSnips'
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
let g:UltiSnipsListSnippets="<c-e>"

" line indenting
let g:indentLine_color_term = 239
let g:indentLine_color_gui = '#A4E57E'
let g:indentLine_char = '│'

" Airline
let g:airline_theme='powerlineish'
"let g:airline_theme='solarized'
let g:airline#extensions#tabline#enabled = 1


" ctrl p ignore
let g:ctrlp_map = '<leader>t'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . --cached --exclude-standard']  " Windows
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|.git\|bower_components\|vendor'

" Nerdtree show hidden files
let NERDTreeShowHidden=1

" vim sessions
let g:session_directory = "~/.vim/session"
let g:session_autoload = "no"
let g:session_autosave = "no"
let g:session_command_aliases = 1

nnoremap <leader>so :OpenSession
nnoremap <leader>ss :SaveSession
nnoremap <leader>sd :DeleteSession<CR>
nnoremap <leader>sc :CloseSession<CR>

"es javascript hint
let g:syntastic_javascript_checkers = ['eslint', 'jshint', 'jsxhint']
let g:syntastic_javascript_jsxhint_exec = 'jsx-jshint-wrapper'
let g:jsx_ext_required = 0

"neocomplcache
let g:neocomplcache_enable_at_startup=1

" emmet
let g:user_emmet_install_global = 0

" }}}
" Conveniece mappings ------------------------------------------------ {{{

" fullscreen mode, only works on windows
nnoremap <leader>F :simalt ~x<cr>

" open a new tab
nnoremap <c-t> :tabnew<cr>

" sudo write
command! W :w !sudo tee %

" NERDTREE
nnoremap <silent> <F4> :NERDTreeToggle<cr>
nnoremap <silent> <F5> :NERDTreeFind<cr>
" for gaming keyboard
nnoremap <leader>d :NERDTreeToggle<cr>
nnoremap <leader>f :NERDTreeFind<cr>

" Tabs
nnoremap <leader>( :tabprev<cr>
nnoremap <leader>) :tabnext<cr>

" Use sane regexes.
nnoremap / /\v
vnoremap / /\v

" Keep search matches in the middle of the window.
nnoremap n nzzzv
nnoremap N Nzzzv

" quick scape to get out of hlsearch
nnoremap <leader><space> :nohl<cr>

" Same when jumping around
nnoremap g; g;zz
nnoremap g, g,zz
noremap <c-o> <c-o>zz

" move faster from the begin of the line to the end of the line
noremap H ^
noremap L g_
nnoremap <Tab> %

" Easy buffer navigation
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" faster saving
nnoremap <leader>w :w<cr>
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<cr>

" Save when losing focus
au FocusLost * :wa

" Resize splits when the window is resized
au VimResized * exe
normal! \<c-w>="

" window resizing
nnoremap <c-left> 5<c-w>>
nnoremap <c-right> 5<c-w><

" formatting, textmate-style
nnoremap Q gqip

" fast sourcing a line
vnoremap <leader>S y:execute @@<cr>
nnoremap <leader>S ^vg_y:execute @@<cr>

" Select (charwise) the content of the current line, excluding indentation
nnoremap VV ^vg_

" insert mode completion
inoremap <c-l> <c-x><c-l>
inoremap <c-f> <c-x><c-f>

" quick edit vimrc
nnoremap <leader>ev :vsp $MYVIMRC<cr>

" I dont record stuff
map qq <Nop>

"easy ecape w/ modding my keyboard
inoremap jj <esc>

" Make tabs, trailing whitespace, and non-breaking spaces visible
"exec "set listchars=tab:▸\ ,trail:\uB7,nbsp:~,eol:¬"
"set listchars=tab:▸\ ,eol:¬,trail:-
set listchars=eol:¬,tab:>-,trail:~,extends:>,precedes:<
set list

" swap : and ; to make colon commands easer to type
nnoremap ; :
nnoremap : ;

" set colorcolumn=81
hi ColorColumn ctermbg=green
call matchadd('ColorColumn', '\%81v', 100)

" Theme stuff
nnoremap <leader>1 :colorscheme solarized<cr>
nnoremap <leader>2 :colorscheme base16-monokai<cr>
" nnoremap <leader>3 :colorscheme molokai<cr>
" nnoremap <leader>4 :colorscheme badwolf<cr>



" }}}
" filetype ----------------------------------------------------------- {{{
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

set omnifunc=syntaxcomplete#Complete
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType apache set commentstring=#\ %s
autocmd FileType html,css,scss,stylus,less EmmetInstall
autocmd FileType java setlocal omnifunc=javacomplete#Complete

au FileType php setl sw=4 sts=4 et
au FileType html setl sw=4 sts=4 et
au FileType stylus setl sw=2 sts=2 et
au FileType less setl sw=4 sts=4 et
au FileType css,scss setl sw=4 sts=4 et
au FileType pug setl sw=2 sts=2 et
au FileType javascript setl sw=2 sts=2 et
au FileType javascript.jsx setl sw=2 sts=2 et
au FileType js,jsx setl sw=2 sts=2 et
" }}}
" airline ------------------------------------------------------------ {{{
function! AirlineInit()
    let g:airline_right_alt_sep = ' '
    let g:airline_right_sep = '  '
    let g:airline_left_alt_sep= '  '
    let g:airline_left_sep = ' '

    let g:airline_section_a = airline#section#create(['mode'])
    let g:airline_section_b = airline#section#create_left(['%P'])
    let g:airline#extensions#hunks#hunk_symbols = ['+', '~', '-']

    let g:airline_section_x = airline#section#create(['hunks','%P',' ','branch'])
    let g:airline_section_y = airline#section#create(['filetype'])
    let g:airline_section_z = airline#section#create_right(['%l','%c'])

endfunction
autocmd VimEnter * call AirlineInit()
" }}}
" functions ---------------------------------------------------------- {{{

" Make sure Vim returns to the same line when you reopen a file.
" https://bitbucket.org/sjl/dotfiles/src/tip/vim/vimrc#cl-175
augroup line_return
    au!
    au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \     execute 'normal! g`"zvzz' |
        \ endif
augroup END

" }}}
" Wildmenu completion ------------------------------------------------ {{{

set wildmenu
set wildmode=list:longest
set wildignore+=.hg,.git,.svn                    " Version control
set wildignore+=*.aux,*.out,*.toc                " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.spl                            " compiled spelling word lists
set wildignore+=*.sw?                            " Vim swap files
set wildignore+=*.DS_Store                       " OSX bullshit
set wildignore+=*.luac                           " Lua byte code
set wildignore+=migrations                       " Django migrations
set wildignore+=*.pyc                            " Python byte code
set wildignore+=*.orig                           " Merge resolution files

" Clojure/Leiningen
set wildignore+=classes
set wildignore+=lib

" }}}
" gui/console -------------------------------------------------------- {{{
if has("gui_running")
    set guioptions= " disable all UI options
    set guicursor+=a:blinkon0 " disable blinking cursor
    set ballooneval
    set lines=40 columns=100
    autocmd GUIEnter * set visualbell t_vb=
    if has("gui_macvim")
        set guifont=Consolas:h15
    elseif has("gui_win32")
        set guifont=Consolas:h11
    endif
else
    set noerrorbells visualbell t_vb=
    if !s:is_nvim
        set term=xterm
    endif
    set t_ut= " setting for looking properly in tmux
    set t_ti= t_te= " prevent vim from clobbering the scrollback buffer
    let &t_Co = 256
    if s:is_windows
        let &t_AF="\e[38;5;%dm"
        let &t_AB="\e[48;5;%dm"
        set ballooneval
        set encoding=utf-8
    endif
    let t_Co = 256
    set ballooneval
    colorscheme base16-monokai
endif

" }}}
