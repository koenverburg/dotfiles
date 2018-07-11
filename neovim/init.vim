" .vimrc
" Author: CreativeKoen <creativekoen@gmail.com>
" Source: https://github.com/CreativeKoen/dotfiles

" Dein --------------------------------------------------------------------- {{{

" set runtimepath += "\\nvim\\bundle\\repos\\github.com\\Shougo\\dein.vim"
set runtimepath += expand($LOCALAPPDATA)."\\nvim\\bundle\\repos\\github.com\\Shougo\\dein.vim"

set nocompatible
filetype off

let loadState = expand($LOCALAPPDATA)."\\nvim"
let deinBeginPath = expand($LOCALAPPDATA)."\\nvim"
let localDeinPath = expand($LOCALAPPDATA)."\\nvim\\bundle\\repos\\github.com\\Shougo\\dein.vim"

if dein#load_state(loadState)
  call dein#begin(deinBeginPath)
  call dein#add(localDeinPath)
  call dein#add('wsdjeg/dein-ui.vim')

  " colorscheme
  call dein#add('rakr/vim-one')
  call dein#add('morhetz/gruvbox')
  call dein#add('ayu-theme/ayu-vim')

  " json
  call dein#add('elzr/vim-json')

  " javascript
  call dein#add('othree/jspc.vim')
  call dein#add('pangloss/vim-javascript')
  " call dein#add('othree/yajs.vim')
  " call dein#add('othree/es.next.syntax.vim')

"   call dein#add('neovim/node-host', { 'build': 'npm install' })
"   call dein#add('billyvg/tigris.nvim', { 'build': './install.sh' })

"   call dein#add('othree/csscomplete.vim')

  " interface
  call dein#add('editorconfig/editorconfig-vim')
  call dein#add('Yggdroot/indentLine')
  call dein#add('godlygeek/tabular')
  call dein#add('kien/ctrlp.vim')
  call dein#add('tacahiroy/ctrlp-funky')
  call dein#add('terryma/vim-multiple-cursors')

  call dein#add('neomake/neomake')
  call dein#add('sbdchd/neoformat')

  call dein#add('mattn/emmet-vim')

  call dein#add('tpope/vim-commentary')
  call dein#add('tpope/vim-surround')
  call dein#add('tpope/vim-fugitive')
  call dein#add('tpope/vim-repeat')

  call dein#add('scrooloose/nerdtree')
  call dein#add('airblade/vim-gitgutter')

  call dein#add('vim-airline/vim-airline')
  call dein#add('vim-airline/vim-airline-themes')

  " zen mode
  call dein#add('junegunn/limelight.vim')
  call dein#add('junegunn/goyo.vim')

  " autocomplete
  call dein#add('Shougo/neco-vim')
  call dein#add('Shougo/denite.nvim')
  call dein#add('Shougo/neosnippet')
  call dein#add('Shougo/neosnippet-snippets')


  " call dein#add('davidhalter/jedi')
  " call dein#add('Shougo/deoplete.nvim')
  " call dein#add('zchee/deoplete-jedi')
  " call dein#add('padawan-php/deoplete-padawan', { 'build': 'composer install'})
  " call dein#add('wokalski/autocomplete-flow')

  "call dein#add('autozimu/LanguageClient-neovim', { 'build': './install.sh'})
  "call dein#add('roxma/nvim-completion-manager', { 'build': 'npm install'})
  "call dein#add('roxma/LanguageServer-php-neovim',  {'build': 'composer install && composer run-script parse-stubs'})

  " misc
  call dein#add('w0rp/ale')
  call dein#add('shougo/echodoc.vim')
  call dein#add('c0r73x/neotags.nvim')
  call dein#add('majutsushi/tagbar')
  call dein#add('xolox/vim-session')
  call dein#add('xolox/vim-misc')

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on                                                       "Enable plugins and indents by filetype
syntax enable

let g:mapleader = ","                                                           "Change leader to a comma

let g:enable_bold_font = 1                                                      "Enable bold font in colorscheme
let g:enable_italic_font = 1                                                    "Enable italic font in colorscheme

 "}}}

" Basic settings ----------------------------------------------------------- {{{

set &runtimepath +='~/AppData/local/nvim/bundle/repos/github.com/w0rp/ale'

set termguicolors
let ayucolor="mirage"   " dark | mirage | light
colorscheme ayu
set background=dark
set fileformat=unix
set fileformats=unix,dos

"No need for ex mode
nnoremap Q <nop>
" recording macros is not my thing
map q <Nop>

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
"   let g:EditorConfig_exec_path = 'editorconfig'
  " let g:EditorConfig_core_mode = 'external_command'
" }}}

" tag bar ------------------------------------------------------------------ {{{
"   nnoremap <silent> <F8> :TagbarToggle<CR>

"   set regexpengine=1
"   let g:neotags_enabled = 1
"   let g:neotags_file = './tags'
"   let g:neotags#python#order = 'mfc'
"   let g:neotags#javascript#order = 'fcfmpv'

"   highlight link PythonMethodTag Special
"   highlight link PythonFunctionTag Special
"   highlight link PythonClassTag Identifier

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

  " Tabular
  if exists(":Tabularize")
    nmap <Leader>a= :Tabularize /=<CR>
    vmap <Leader>a= :Tabularize /=<CR>
    nmap <Leader>a: :Tabularize /:\zs<CR>
    vmap <Leader>a: :Tabularize /:\zs<CR>
  endif"

  " Airline
  let g:airline_theme = 'deus'
  let g:airline#extensions#tabline#enabled = 1

  " Nerdtree show hidden files
  let NERDTreeShowHidden = 1
  let NERDTreeShowLineNumbers = 0

  " vim sessions
  let g:session_directory = $LOCALAPPDATA/nvim-data/session"
  let g:session_autoload = "no"
  let g:session_autosave = "no"
  let g:session_command_aliases = 1

  nnoremap <leader>so :OpenSession
  nnoremap <leader>ss :SaveSession
  nnoremap <leader>sd :DeleteSession<CR>
  nnoremap <leader>sc :CloseSession<CR>

  " ctrl p ignore
  let g:ctrlp_map = '<leader>t'
  let g:ctrlp_cmd = 'CtrlP'
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . --cached --exclude-standard']  " Windows
  let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|.git\|bower_components\|vendor|bin\|public\'

  " clang
  let g:chromatica#libclang_path='C:\Program Files\LLVM\lib'
  let g:chromatica#enable_at_startup = 1

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
nnoremap <leader>ev :vsp $LOCALAPPDATA/nvim/init.vim<cr>

" I dont record stuff
map qq <Nop>
nnoremap qq <Nop>

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

" add easy date insertion
imap <Leader>ds     <C-R>=strftime("%Y-%m-%d %T")<CR>
imap <Leader>ymd    <C-R>=strftime("%Y-%m-%d")<CR>
imap <Leader>mdy    <C-R>=strftime("%m/%d/%y")<CR>
imap <Leader>Mdy    <C-R>=strftime("%b %d, %Y")<CR>
imap <Leader>hms    <C-R>=strftime("%T")<CR>

" moving the tabs
nnoremap <silent> <A-Left> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> <A-Right> :execute 'silent! tabmove ' . tabpagenr()<CR>

" }}}

" backup ------------------------------------------------------------------- {{{

  set backup
  set undofile
  set backupdir = $LOCALAPPDATA/nvim/data/backup/
  set undodir   = $LOCALAPPDATA/nvim/data/undo/
  set directory = $LOCALAPPDATA/nvim/data/swap/

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

"}}}

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

"   set signcolumn=yes
"   let g:conflict_marker_enable_mappings = 0
"   let g:gitgutter_sign_added = '│'
"   let g:gitgutter_sign_modified = '│'
"   let g:gitgutter_sign_removed = '│'
"   let g:gitgutter_sign_removed_first_line = '│'
"   let g:gitgutter_sign_modified_removed = '│'

" }}}

" Linting ------------------------------------------------------------------ {{{

"   call neomake#configure#automake({
"   \ 'BufWritePost': {'delay': 0},
"   \ }, 1000)

"   let g:ale_sign_error = '•'
"   let g:ale_sign_warning = '•'

"   let g:airline#extensions#ale#error_symbol='•'
"   let g:airline#extensions#ale#warning_symbol='•'

"   let g:neomake_error_sign = {'text': '•'}
"   let g:neomake_warning_sign = {'text': '•'}
"   let g:airline#extensions#neomake#error_symbol='•'
"   let g:airline#extensions#neomake#warning_symbol='•'

"   hi link ALEError SpellBad
"   hi link ALEWarning SpellBad
  " Write this in your vimrc file
"   let g:ale_lint_on_text_changed = 'never'
"   let g:ale_lint_on_enter = 0
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

" Snipppets -----------------------------------------------------------------{{{

" Enable snipMate compatibility feature.
"   let g:neosnippet#enable_snipmate_compatibility = 1
"   " let g:neosnippet#snippets_directory='~/GitHub/ionic-snippets'
"   " let g:neosnippet#expand_word_boundary = 1
"   imap <C-k>     <Plug>(neosnippet_expand_or_jump)
"   smap <C-k>     <Plug>(neosnippet_expand_or_jump)
"   xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
  " imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
  " \ "\<Plug>(neosnippet_expand_or_jump)"
  " \: pumvisible() ? "\<C-n>" : "\<TAB>"
  " smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
  " \ "\<Plug>(neosnippet_expand_or_jump)"
  " \: "\<TAB>"

"}}}

" Javascript --------------------------------------------------------------- {{{

"   let g:javascript_plugin_flow = 1
"   let g:javascript_plugin_jsdoc = 1

"   let g:javascript_conceal_function             = "ƒ"
"   let g:javascript_conceal_null                 = "ø"
"   let g:javascript_conceal_this                 = "@"
"   let g:javascript_conceal_return               = "⇚"
"   let g:javascript_conceal_undefined            = "¿"
"   let g:javascript_conceal_NaN                  = "ℕ"
"   let g:javascript_conceal_prototype            = "¶"
"   let g:javascript_conceal_static               = "•"
"   let g:javascript_conceal_super                = "Ω"
"   let g:javascript_conceal_arrow_function       = "⇒"
"   let g:javascript_conceal_noarg_arrow_function = ""
"   let g:javascript_conceal_underscore_arrow_function = ""

"   let g:neoformat_javascript_prettier = g:standard_prettier_settings
"   let g:neoformat_enabled_javascript = ['prettier']

"   let g:neomake_javascript_enabled_makers = ['standard']
"   let g:jsx_ext_required = 1
"   let g:jsdoc_allow_input_prompt = 1
"   let g:jsdoc_input_description = 1
"   let g:jsdoc_return=0
"   let g:jsdoc_return_type=0
"   let g:vim_json_syntax_conceal = 0

"   let g:tigris#enabled = 1

"}}}

" Python ------------------------------------------------------------------- {{{

  " let g:python3_host_prog = '/usr/local/bin/python3'
  " let g:jedi#auto_vim_configuration = 0
  " let g:jedi#documentation_command = "<leader>k"
  " let g:jedi#completions_enabled = 0

" }}}

" CSS ---------------------------------------------------------------------- {{{

"   let g:neoformat_scss_prettier = g:standard_prettier_settings
"   let g:neoformat_enabled_scss = ['prettier']
"   let g:neomake_scss_enabled_makers = ['scsslint']

"}}}

" HTML --------------------------------------------------------------------- {{{

"   let g:neomake_html_enabled_makers = []
"   let g:neoformat_enabled_html = ['htmlbeautify']

" }}}

" Airline customization ---------------------------------------------------- {{{

  let g:airline_powerline_fonts = 1
  let g:airline#extensions#tabline#enabled = 1
  function! AirlineInit()
    let g:airline_section_a = airline#section#create(['mode'])
    let g:airline_section_b = airline#section#create_left(['%P'])
    let g:airline#extensions#hunks#hunk_symbols = ['+', '~', '-']

    let g:airline_section_x = airline#section#create(['hunks','%P',' ','branch'])
    let g:airline_section_y = airline#section#create(['filetype'])
    let g:airline_section_z = airline#section#create_right(['%l','%c'])

    let g:airline_section_error = '%{ALEGetStatusLine()}'
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

" theme
nnoremap <leader>2 :colorscheme one<cr>
nnoremap <leader>3 :colorscheme gruvbox<cr>
nnoremap <leader>3 :colorscheme ayu<cr>
