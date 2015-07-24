" .vimrc
" Author: CreativeKoen <creativekoen@gmail.com>
" Source: https://github.com/CreativeKoen/dotfiles
"
" This file changes a lot.  I'll try to document pieces of it whenever I have
" a few minutes to kill.

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
    Plugin 'moll/vim-node'
    Plugin 'mattn/emmet-vim' " ctrl y RELEASE ,
" hightlight
    Plugin 'altercation/vim-colors-solarized'
    Plugin 'chriskempson/base16-vim'
    Plugin 'ap/vim-css-color'                   " see what the hex color is
    Plugin 'sheerun/vim-polyglot'               " support a whole lot of filetypes
    " {{{
    "Plugin 'jelera/vim-javascript-syntax'
    "Plugin 'digitaltoad/vim-jade'
    "Plugin 'wavded/vim-stylus'
    "Plugin 'kchmck/vim-coffee-script'
    "Plugin 'vim-ruby/vim-ruby'
    "Plugin 'tpope/vim-markdown'
    "Plugin 'StanAngeloff/php.vim'
    "Plugin 'octol/vim-cpp-enhanced-highlight'
    "Plugin 'bps/vim-textobj-python'
    " }}}
" VIM INTERFACE
    Plugin 'scrooloose/syntastic'
    Plugin 'vim-scripts/matchit.zip'
    Plugin 'editorconfig/editorconfig-vim'
    Plugin 'Lokaltog/vim-easymotion'
    Plugin 'scrooloose/nerdtree'
    Plugin 'bling/vim-airline'
    Plugin 'tpope/vim-commentary'               "select with v and comment with gc
    Plugin 'tpope/vim-fugitive'
    Plugin 'tpope/vim-surround'
    Plugin 'townk/vim-autoclose'
    Plugin 'kien/ctrlp.vim'
    Plugin 'airblade/vim-gitgutter'
    Plugin 'Yggdroot/indentLine'
    Plugin 'xolox/vim-session'
    Plugin 'xolox/vim-misc'
"snippets
    Plugin 'MarcWeber/vim-addon-mw-utils'
    Plugin 'sirver/ultisnips'
    Plugin 'tomtom/tlib_vim'
    Plugin 'garbas/vim-snipmate'
    Plugin 'honza/vim-snippets'
" autocomplete
    Plugin 'myhere/vim-nodejs-complete'
    Plugin 'shawncplus/phpcomplete.vim'
    Plugin 'shougo/neocomplcache.vim'
call vundle#end()
" }}}
" after vundle  ------------------------------------------------------ {{{
filetype plugin indent on
syntax on

colorscheme solarized
set background=dark

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
" taps {{{
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
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
let g:UltiSnipsSnippetsDir = '~/.vim/bundle/vim-snippets/UltiSnips'
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
let g:UltiSnipsListSnippets="<c-e>"

let g:indentLine_color_term = 239
let g:indentLine_color_gui = '#A4E57E'

let g:airline_theme='powerlineish'
let g:airline#extensions#tabline#enabled = 1

let NERDTreeShowHidden=1

let g:user_emmet_install_global = 0

let g:neocomplcache_enable_at_startup=1

" vim sessions
let g:session_directory = "~/.vim/session"
let g:session_autoload = "no"
let g:session_autosave = "no"
let g:session_command_aliases = 1
nnoremap <leader>so :OpenSession
nnoremap <leader>ss :SaveSession
nnoremap <leader>sd :DeleteSession<CR>
nnoremap <leader>sc :CloseSession<CR>

" }}}
" Conveniece mappings ------------------------------------------------ {{{

" fullscreen mode
nnoremap <leader>f :simalt ~x<cr>

" open a new tab
nnoremap <c-t> :tabnew<cr>

" sudo write
command! W :w !sudo tee %


" Tree
nnoremap <silent> <F4> :NERDTreeToggle<CR>
nnoremap <silent> <F5> :NERDTreeFind<CR>

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
nnoremap <leader><c-n> :nohlsearch<CR>

" Same when jumping around
" nnoremap g; g;zz
" nnoremap g, g,zz
" noremap <c-o> <c-o>zz

" faster movie from the begin of the line to the end of the line
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

" Save when losing focus
au FocusLost * :wa

" Resize splits when the window is resized
"au VimResized * exe
"normal! \<c-w>="

" window resizing
nnoremap <c-left> 5<c-w>>
nnoremap <c-right> 5<c-w><


" Kill the window
nnoremap K :q<cr>

" formatting, taxtmate-style
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

" I dont record stuff vim
nnoremap qq :w


" Make tabs, trailing whitespace, and non-breaking spaces visible
"exec "set listchars=tab:▸\ ,trail:\uB7,nbsp:~,eol:¬"
set listchars=tab:▸\ ,eol:¬,trail:-
set list


" swap : and ; to make colon commands easer to type
nnoremap ; :
nnoremap : ;

" set colorcolumn=81
hi ColorColumn ctermbg=green
call matchadd('ColorColumn', '\%81v', 100)



" }}}
" filetype ----------------------------------------------------------- {{{
set omnifunc=syntaxcomplete#Complete
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType apache set commentstring=#\ %s
autocmd FileType html,css,scss,stylus,jade EmmetInstall
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
" augroup relative_line_numbers

"     autocmd!

"     " Automatically switch to absolute line numbers when vim loses focus
"     autocmd FocusLost * :set number

"     " Automatically switch to relative line numbers when vim gains focus
"     autocmd FocusGained * :set relativenumber

"     " Automatically switch to absolute line numbers when vim is in insert mode
"     autocmd InsertEnter * :set number

"     " Automatically switch to relative line numbers when vim is in normal mode
"     autocmd InsertLeave * :set relativenumber

" augroup END
"Make sure Vim returns to the same line when you reopen a file.
"
" Make sure Vim returns to the same line when you reopen a file.
" https://bitbucket.org/sjl/dotfiles/src/tip/vim/vimrc#cl-175
augroup line_return
    au!
    au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \     execute 'normal! g`"zvzz' |
        \ endif
augroup END

" augroup reload_vimrc
"     autocmd!
"     autocmd bufwritepost $MYVIMRC nested source $MYVIMRC
" augroup END




" }}}
" powershell --------------------------------------------------------- {{{
" change to powershell
" if has("gui_win32")
"     set shell=powershell.exe\ -ExecutionPolicy\ Unrestricted
"     set shellcmdflag=-Command
"     set shellpipe=>
"     set shellredir=>
" endif
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
    set number
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
    " colorscheme solarized
    " let g:airline_theme='solarized'
endif

" }}}
