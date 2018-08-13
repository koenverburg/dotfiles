" .vimrc
" Author: Koen Verburg <creativekoen@gmail.com>
" Source: https://github.com/CreativeKoen/dotfiles

" Plug --------------------------------------------------------------------- {{{
let g:plugin_dir = expand('~/.neovim/cache/')

set nocompatible
filetype off

call plug#begin(g:plugin_dir)

" colorschemes
Plug 'rakr/vim-one'
Plug 'morhetz/gruvbox'
Plug 'ayu-theme/ayu-vim'

" json
Plug 'elzr/vim-json'

" javascript
Plug 'othree/jspc.vim'
Plug 'pangloss/vim-javascript'
Plug 'othree/yajs.vim'
Plug 'othree/es.next.syntax.vim'

" css
Plug 'othree/csscomplete.vim'

" graphql
Plug 'jparise/vim-graphql'


" interface
Plug 'editorconfig/editorconfig-vim'
Plug 'Yggdroot/indentLine'
Plug 'godlygeek/tabular'
Plug 'kien/ctrlp.vim'
Plug 'tacahiroy/ctrlp-funky'
Plug 'terryma/vim-multiple-cursors'

Plug 'neomake/neomake'
Plug 'sbdchd/neoformat'

Plug 'mattn/emmet-vim'

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'

Plug 'scrooloose/nerdtree'
Plug 'airblade/vim-gitgutter'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" misc
"Plug 'w0rp/ale'
"Plug 'shougo/echodoc.vim'
"Plug 'c0r73x/neotags.nvim'
"Plug 'majutsushi/tagbar'
Plug 'xolox/vim-session'
Plug 'xolox/vim-misc'

" Zen
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

call plug#end()

"   " autocomplete
"   call dein#add('Shougo/neco-vim')
"   call dein#add('Shougo/denite.nvim')
"   call dein#add('Shougo/neosnippet')
"   call dein#add('Shougo/neosnippet-snippets')


  " call dein#add('davidhalter/jedi')
  " call dein#add('Shougo/deoplete.nvim')
  " call dein#add('zchee/deoplete-jedi')
  " call dein#add('padawan-php/deoplete-padawan', { 'build': 'composer install'})
  " call dein#add('wokalski/autocomplete-flow')

  "call dein#add('autozimu/LanguageClient-neovim', { 'build': './install.sh'})
  "call dein#add('roxma/nvim-completion-manager', { 'build': 'npm install'})
  "call dein#add('roxma/LanguageServer-php-neovim',  {'build': 'composer install && composer run-script parse-stubs'})


filetype plugin indent on                                                       "Enable plugins and indents by filetype
syntax enable

let g:mapleader = ","                                                           "Change leader to a comma

let g:enable_bold_font = 1                                                      "Enable bold font in colorscheme
let g:enable_italic_font = 1                                                    "Enable italic font in colorscheme

 "}}}

" Basic settings ----------------------------------------------------------- {{{
set &runtimepath += '~/.neovim/cache/ale'

set termguicolors
let ayucolor="mirage"   " dark | mirage | light
colorscheme ayu
set background=dark
set fileformat=unix
set fileformats=unix,dos

" set relativenumber
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
set completeopt=longest,menuone,preview
set backspace=2
set backspace=indent,eol,start
set scrolloff=15
set matchpairs+=<:>  "This is key in frontend development

" Leader
let mapleader = ","
let maplocalleader = "\\"

"let me paste from system clipboar
set clipboard+=unnamed

if has("multi_byte")
    if &termencoding == ""
        let &termencoding = &encoding
    endif
    set encoding=utf-8
    setglobal fileencoding=utf-8
    "setglobal bomb
    set fileencodings=ucs-bom,utf-8,latin1
endif

au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif

" }}}

" editor config ------------------------------------------------------------ {{{
  let g:EditorConfig_exec_path = 'editorconfig'
" }}}

" tag bar ------------------------------------------------------------------ {{{
  " nnoremap <silent> <F8> :TagbarToggle<CR>

  " set regexpengine=1
  " let g:neotags_enabled = 1
  " let g:neotags_file = './tags'
  " let g:neotags#python#order = 'mfc'
  " let g:neotags#javascript#order = 'fcfmpv'

  " highlight link PythonMethodTag Special
  " highlight link PythonFunctionTag Special
  " highlight link PythonClassTag Identifier

  " highlight link javascriptFunctionTag Identifier

" }}}

" indent lines ------------------------------------------------------------- {{{

  let g:indentLine_enabled = 0
  let g:indentLine_setColors = 0
  let g:indentLine_leadingSpaceEnabled = 1
  let g:indentLine_setConceal = 1;
  let g:indentLine_leadingSpaceChar = '·'
  "let g:indentLine_color_gui = #504945
  "let g:indentLine_char = '|'
" }}}

" plugin setting ----------------------------------------------------------- {{{

  " Json
  let g:vim_json_syntax_conceal = 0                                             " I want to see the quote's

"   " Tabular
  if exists(":Tabularize")
    nmap <Leader>a= :Tabularize /=<CR>
    vmap <Leader>a= :Tabularize /=<CR>
    nmap <Leader>a: :Tabularize /:\zs<CR>
    vmap <Leader>a: :Tabularize /:\zs<CR>
  endif"

"   " Airline
  let g:airline_theme = 'deus'
  let g:airline#extensions#tabline#enabled = 1

"   " Nerdtree show hidden files
  let NERDTreeShowHidden = 1
  let NERDTreeShowLineNumbers = 0

"   " vim sessions
  let g:session_directory = "~/.neovim/data/session"
  let g:session_autoload = "no"
  let g:session_autosave = "no"
  let g:session_command_aliases = 1

  nnoremap <leader>so :OpenSession
  nnoremap <leader>ss :SaveSession
  nnoremap <leader>sd :DeleteSession<CR>
  nnoremap <leader>sc :CloseSession<CR>

"   " ctrl p ignore
"   let g:ctrlp_map = '<leader>t'
"   let g:ctrlp_cmd = 'CtrlP'
"   let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . --cached --exclude-standard']  " Windows
"   let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|.git\|bower_components\|vendor|bin\|public\'

" }}}

" Conveniece mappings ------------------------------------------------------ {{{

" zen mode
nnoremap <silent> <leader>Z :Goyo 80%x80%<cr>

" open a new tab
nnoremap <c-t> :tabnew<cr>

" sudo write
command! W :w !sudo tee %

" NERDTREE
nnoremap <silent> <F4> :NERDTreeToggle<cr>
nnoremap <silent> <F5> :NERDTreeFind<cr>

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

" Easy buffer/pane navigation
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

" Quick edit vimrc
nnoremap <leader>ev :vsp  $localappdata/nvim/init.vim<cr>

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

set colorcolumn=81
hi ColorColumn ctermbg=green
call matchadd('ColorColumn', '\%81v', 100)

" moving the tabs
nnoremap <silent> <A-Left> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> <A-Right> :execute 'silent! tabmove ' . tabpagenr()<CR>

" }}}

" Fold, gets it's own section  --------------------------------------------- {{{

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

" }}}

" Git ---------------------------------------------------------------------- {{{

  set signcolumn=yes
  let g:conflict_marker_enable_mappings = 0
  let g:gitgutter_sign_added = '│'
  let g:gitgutter_sign_modified = '│'
  let g:gitgutter_sign_removed = '│'
  let g:gitgutter_sign_removed_first_line = '│'
  let g:gitgutter_sign_modified_removed = '│'

" }}}

" Linting off ------------------------------------------------------------------ {{{

  " call neomake#configure#automake({
  " \ 'BufWritePost': { 'delay': 0 },
  " \ }, 1000)

  " let g:ale_sign_error = '•'
  " let g:ale_sign_warning = '•'

  " let g:airline#extensions#ale#error_symbol='•'
  " let g:airline#extensions#ale#warning_symbol='•'

  " let g:neomake_error_sign = {'text': '•'}
  " let g:neomake_warning_sign = {'text': '•'}
  " let g:airline#extensions#neomake#error_symbol='•'
  " let g:airline#extensions#neomake#warning_symbol='•'

"   hi link ALEError SpellBad
"   hi link ALEWarning SpellBad
  " Write this in your vimrc file
  " let g:ale_lint_on_text_changed = 'never'
  " let g:ale_lint_on_enter = 0
  " let g:neomake_verbose = 3
"}}}

" Nvim terminal ------------------------------------------------------------ {{{

  au BufEnter * if &buftype == 'terminal' | :startinsert | endif
  autocmd BufEnter term://* startinsert
  autocmd TermOpen * set bufhidden=hide

" }}}

" MultiCursor -------------------------------------------------------------- {{{

let g:multi_cursor_exit_from_visual_mode=0
let g:multi_cursor_exit_from_insert_mode=0

"}}}

" neoformat (js,css,html)
" general
" let g:neoformat_scss_prettier = g:standard_prettier_settings
" let g:neoformat_javascript_prettier = g:standard_prettier_settings

" " scss
" let g:neoformat_enabled_scss = ['prettier']
" let g:neomake_scss_enabled_makers = ['scsslint']

" " javascript
" let g:neoformat_enabled_javascript = ['prettier']
" let g:neomake_javascript_enabled_makers = ['eslint']

" " html,php
" let g:neomake_html_enabled_makers = []
" let g:neoformat_enabled_html = ['htmlbeautify']

" Javascript --------------------------------------------------------------- {{{

  let g:javascript_plugin_flow = 1
  let g:javascript_plugin_jsdoc = 1

"   let g:javascript_conceal_function             = "ƒ"
  let g:javascript_conceal_null                 = "ø"
  let g:javascript_conceal_this                 = "@"
  let g:javascript_conceal_return               = "⇚"
  let g:javascript_conceal_undefined            = "¿"
  let g:javascript_conceal_NaN                  = "ℕ"
  let g:javascript_conceal_prototype            = "¶"
  let g:javascript_conceal_static               = "•"
  let g:javascript_conceal_super                = "Ω"
  let g:javascript_conceal_arrow_function       = "⇒"
" let g:javascript_conceal_noarg_arrow_function = ""
" let g:javascript_conceal_underscore_arrow_function = ""

  let g:jsx_ext_required = 1
  let g:jsdoc_allow_input_prompt = 1
  let g:jsdoc_input_description = 1
  let g:jsdoc_return=0
  let g:jsdoc_return_type=0
  let g:vim_json_syntax_conceal = 0

  let g:tigris#enabled = 1

"}}}

" CSS OFF  ---------------------------------------------------------------------- {{{


"}}}

" HTML OFF --------------------------------------------------------------------- {{{


" }}}

" Airline customization ---------------------------------------------------- {{{

  let g:airline_powerline_fonts = 1
  let g:airline#extensions#tabline#enabled = 1

function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors

    return l:counts.total == 0 ? 'OK' : printf(
    \   '%dW %dE',
    \   all_non_errors,
    \   all_errors
    \)
endfunction

  function! AirlineInit()
    let g:airline_section_a = airline#section#create(['mode'])
    let g:airline_section_b = airline#section#create_left(['%P'])
    let g:airline#extensions#hunks#hunk_symbols = ['+', '~', '-']

    let g:airline_section_x = airline#section#create(['hunks','%P',' ','branch'])
    let g:airline_section_y = airline#section#create(['filetype'])
    let g:airline_section_z = airline#section#create_right(['%l','%c'])

    let g:airline_section_error = '%{LinterStatus()}'
  endfunction
  autocmd VimEnter * call AirlineInit()

" }}}

" Vim functions ------------------------------------------------------------ {{{

" Make sure Vim returns to the same line when you reopen a file.
" https://bitbucket.org/sjl/dotfiles/src/tip/vim/vimrc#cl-175
  augroup line_return
    au!
    au BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \   execute 'normal! g`"zvzz' |
      \ endif
  augroup END

" }}}

" Wildmenu completion ------------------------------------------------------ {{{

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
set wildignore+=*.pyc                            " Python byte code
set wildignore+=*.orig                           " Merge resolution files
set wildignore+=migrations                       " Django migrations
set wildignore+=database                         " knex migrations

" }}}

" " theme
nnoremap <leader>2 :colorscheme one<cr>
nnoremap <leader>3 :colorscheme gruvbox<cr>
nnoremap <leader>3 :colorscheme ayu<cr>

" let g:python3_host_prog='C:/Users/koenv/Envs/neovim3/Scripts/python.exe'
let g:python_host_prog='C:/Python27/python.exe'
