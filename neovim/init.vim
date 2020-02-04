" .vimrc
" Author: Koen Verburg <creativekoen@gmail.com>
" Source: https://github.com/koenverburg/dotfiles

" Plug --------------------------------------------------------------------- {{{
let g:plugin_dir = expand('~/.neovim/plugin')

set nocompatible
filetype off

call plug#begin(g:plugin_dir)

" ================= looks and GUI stuff ================== "
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'                          " airline status bar
Plug 'vim-airline/vim-airline-themes'                   " airline themes
Plug 'gregsexton/MatchTag'                              " highlight matching html tags

" ================= Functionalities ================= "

" auto completion, lang servers and stuff
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'desmap/ale-sensible' | Plug 'w0rp/ale', { 'for': ['typescript', 'javascript'] }
Plug 'bkad/CamelCaseMotion'

" search
Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'
Plug 'brooth/far.vim'

" snippets
" Plug 'SirVer/ultisnips'
" Plug 'honza/vim-snippets'                               " actual snippets

" visual
Plug 'alvan/vim-closetag'                               " auto close html tags
Plug 'Yggdroot/indentLine'                              " show indentation lines


" languages
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'elzr/vim-json'
Plug 'mxw/vim-jsx'
Plug 'othree/yajs.vim'
Plug 'pangloss/vim-javascript'
Plug 'elixir-lang/vim-elixir'
Plug 'thinca/vim-ref'

" Plug 'sheerun/vim-polyglot'                             " many languages support
" Plug 'tpope/vim-liquid'                                 " liquid language support

" other
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-commentary'                             " better commenting
Plug 'tpope/vim-sensible'                               " sensible defaults
Plug 'tpope/vim-fugitive'                               " git support
Plug 'tpope/vim-surround'                               " surround stuff with stuff
Plug 'psliwka/vim-smoothie'                             " some very smooth ass scrolling
Plug 'farmergreg/vim-lastplace'                         " open files at the last edited place

" Plug 'majutsushi/tagbar', { 'for': ['python'] }
" Plug 'liuchengxu/vista.vim', { 'for': ['elixir', 'typescript', 'javascript'] }

" Zen
"Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
" interface
Plug 'editorconfig/editorconfig-vim'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdtree'

call plug#end()

filetype plugin indent on                                                       "Enable plugins and indents by filetype
syntax enable

" set runtimepath^=expand('~/.neovim/plugin/vista.vim')

let g:mapleader = ","                                                           "Change leader to a comma
let g:enable_bold_font = 1                                                      "Enable bold font in colorscheme
let g:enable_italic_font = 0                                                    "Enable italic font in colorscheme

 "}}}

" Basic settings ----------------------------------------------------------- {{{

colorscheme gruvbox
syntax enable    " enable syntax highlighting

filetype plugin indent on                               " enable indentations
set background=dark

highlight Pmenu guibg=white guifg=black gui=bold
highlight Comment gui=bold
highlight Normal gui=none
highlight NonText guibg=none
autocmd ColorScheme * highlight VertSplit cterm=NONE ctermfg=Green ctermbg=NONE

syntax enable    " enable syntax highlighting

" ==================== general config ======================== "

set termguicolors                                       " Opaque Background
set mouse=a                                             " enable mouse scrolling
set clipboard+=unnamed,unnamedplus                      " use system clipboard by default
" C-c and C-v - Copy/Paste to global clipboard
vmap <C-c> "+yi
imap <C-v> <esc>"+gpi
" ===================== Other Configurations ===================== "

set listchars=eol:¬,tab:>-,trail:~,extends:>,precedes:<
set emoji                                               " enable emojis
set autoindent   " Copy indent from current line when starting a new line
set showcmd      " display incomplete commands
set showmode     " display the mode you're in
set backspace=indent,eol,start " intuitive backspacing"
set hidden       " Handle multiple buffers better
set wildmenu     " enhanced command line completion
set wildmode=list:longest " complete files like a shell

""" Search
set ignorecase   " case-insensitive search
set smartcase    " but case-sensitive if expression contains a capital letter
set relativenumber " show relative line number
set number         " show the line number of the current line
set ruler        " show cursor position
set incsearch    " highlight matches as you type
set hlsearch     " highlight matches

""" Regex
set gdefault     " use global option in regex by default

set wrap         " turn on line wrapping
set scrolloff=3  " show 3 lines of context around cursor
set display+=lastline " Display as much as possible of a window's last line
set list         " show invisible characters
set title        " show terminal title
set visualbell   " no beeping

"" Global tabs/spaces
set smarttab     " use spaces instead of tabs
set tabstop=2    " global tab width
set shiftwidth=2
set expandtab    " use spaces instead of tabs
set laststatus=2 " Always show a status line

set nobackup " no backups
set nowritebackup " No backups
set noswapfile " No swap files
set autoread " Automatically re-read files changed outside of vim
set encoding=utf-8
set updatetime=300
set shortmess+=c
set signcolumn=yes
let g:indentLine_setConceal = 0                         " actually fix the annoying markdown links conversion

" Leader
let mapleader = ","
let maplocalleader = "\\"

call rpcnotify(1, 'Gui', 'Option', 'Tabline', 0)

if has("multi_byte")
  if &termencoding == ""
    let &termencoding = &encoding
  endif

  setglobal fileencoding=utf-8
  "setglobal bomb
  set fileencodings=ucs-bom,utf-8,latin1
endif

au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif

" }}}

" plugin setting ----------------------------------------------------------- {{{

" typescript and react
" dark red
  hi tsxTagName guifg=#E06C75

  " orange
  hi tsxCloseString guifg=#F99575
  hi tsxCloseTag guifg=#F99575
  hi tsxCloseTagName guifg=#F99575
  hi tsxAttributeBraces guifg=#F99575
  hi tsxEqual guifg=#F99575

  " yellow
  hi tsxAttrib guifg=#F8BD7F cterm=italic
  " light-grey
  hi tsxTypeBraces guifg=#999999
  " dark-grey
  hi tsxTypes guifg=#666666

  hi ReactState guifg=#C176A7
  hi ReactProps guifg=#D19A66
  hi ApolloGraphQL guifg=#CB886B
  hi Events ctermfg=204 guifg=#56B6C2
  hi ReduxKeywords ctermfg=204 guifg=#C678DD
  hi ReduxHooksKeywords ctermfg=204 guifg=#C176A7
  hi WebBrowser ctermfg=204 guifg=#56B6C2
  hi ReactLifeCycleMethods ctermfg=204 guifg=#D19A66

  let g:indentLine_enabled = 0
  let g:indentLine_setColors = 0
  let g:indentLine_leadingSpaceEnabled = 1

  let g:EditorConfig_exec_path = 'editorconfig'

  " Json
  let g:vim_json_syntax_conceal = 0                                             " I want to see the quote's

  " Airline
  let g:airline_theme = 'gruvbox'
  let g:airline#extensions#tabline#enabled = 1


  let g:conflict_marker_enable_mappings = 0
  let g:gitgutter_sign_added = '│'
  let g:gitgutter_sign_modified = '│'
  let g:gitgutter_sign_removed = '│'
  let g:gitgutter_sign_removed_first_line = '│'
  let g:gitgutter_sign_modified_removed = '│'

  let g:javascript_plugin_flow = 1
  let g:javascript_plugin_jsdoc = 1
  let g:jsx_ext_required = 1
  let g:vim_json_syntax_conceal = 0
  let g:tigris#enabled = 1

  let g:airline_powerline_fonts = 1
  let g:airline#extensions#tabline#enabled = 1

  let NERDTreeShowHidden = 1
  let NERDTreeShowLineNumbers = 0

  nnoremap <silent><leader>nn :NERDTreeToggle<cr>
  inoremap <silent><leader>nn :NERDTreeToggle<cr>

  autocmd BufEnter NERD_tree* :LeadingSpaceDisable

  " WordJumping like in vscode and resharper
  imap <silent> <S-Left> <C-o><Plug>CamelCaseMotion_b
  imap <silent> <S-Right> <C-o><Plug>CamelCaseMotion_w

  map <silent> w <Plug>CamelCaseMotion_w
  map <silent> b <Plug>CamelCaseMotion_b
  map <silent> e <Plug>CamelCaseMotion_e
  map <silent> ge <Plug>CamelCaseMotion_ge
  sunmap w
  sunmap b
  sunmap e
  sunmap ge

  " Tag bar
  nmap <F8> :Vista<CR>

  let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
  let g:vista_default_executive = 'ctags'

  " let g:vista_executive_for = {
  "   \ 'javascript': 'ale',
  "   \ 'typescript': 'ale',
  "   \ }

  " Ensure you have installed some decent font to show these pretty symbols, then you can enable icon for the kind.
  let g:vista#renderer#enable_icon = 1

  " The default icons can't be suitable for all the filetypes, you can extend it as you wish.
  let g:vista#renderer#icons = {
  \   "function": "\uf794",
  \   "variable": "\uf71b",
  \  }


  " FZF
  nnoremap <silent><leader>ff :FZF<cr>
  inoremap <silent><leader>ff :FZF<cr>

  " let $FZF_DEFAULT_OPTS .= '--color=bg:#20242C --border --layout=reverse'
  " function! FloatingFZF()
  "   let width = float2nr(&columns * 0.9)
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

  " let g:fzf_layout = { 'window': 'call FloatingFZF()' }

  " Search
  if executable('ag')
    let g:ackprg = 'ag --vimgrep'
  endif

  cnoreabbrev Ack Ack!
  nnoremap <Leader>a :Ack!<Space>
" }}}

" COC settings ------------------------------------------------------------- {{{
  let g:coc_global_extensions = [ 'coc-tslint-plugin', 'coc-tsserver', 'coc-emmet', 'coc-css', 'coc-html', 'coc-json', 'coc-yank', 'coc-prettier', 'coc-actions', 'coc-elixir']

  " let g:coc_user_config = {}
  " let g:coc_user_config['coc.preferences.hoverTarget'] = 'echo'
  " let g:coc_user_config['signature.target'] = 'echo'

  " nmap <silent> gd <Plug>(coc-definition)
  " " Remap for do codeAction of selected region
  " function! s:cocActionsOpenFromSelected(type) abort
  "   execute 'CocCommand actions.open ' . a:type
  " endfunction
  " xmap <silent> <leader>a :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>
  " nmap <silent> <leader>a :<C-u>set operatorfunc=<SID>cocActionsOpenFromSelected<CR>g@
" }}}

" Denite for fuzzy seearching {{{

" }}}

" Conveniece mappings ------------------------------------------------------ {{{

" open a new tab
nnoremap <c-t> :tabnew<cr>

" sudo write
command! W :w !sudo tee %

" Tabs
nnoremap <leader>( :tabprev<cr>
nnoremap <leader>) :tabnext<cr>

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

" Python VirtualEnv
"let g:python_host_prog =  expand('/usr/bin/python')
let g:python3_host_prog = expand('C:\tools\python3\python.exe')

" }}}

" tabs manipulation -------------------------------------------------------- {{{
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
"}}}

" Folding, gets it's own section ------------------------------------------- {{{

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

"Auto cmd stuff ------------------------------------------------------------ {{{

  au BufEnter * if &buftype == 'terminal' | :startinsert | endif
  autocmd BufEnter term://* startinsert
  autocmd TermOpen * set bufhidden=hide

  autocmd BufNewFile,BufRead *.ts setlocal filetype=typescript
  autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescript.tsx

" }}}

" Airline customization ---------------------------------------------------- {{{

  function! AirlineInit()
    let g:airline_section_a = airline#section#create(['mode'])
    let g:airline_section_b = airline#section#create_left(['%P'])
    let g:airline#extensions#hunks#hunk_symbols = ['+', '~', '-']

    let g:airline_section_x = airline#section#create(['hunks','%P',' ','branch'])
    let g:airline_section_y = airline#section#create(['filetype'])
    let g:airline_section_z = airline#section#create_right(['%l','%c'])
  endfunction

  autocmd VimEnter * call AirlineInit()
" }}}
