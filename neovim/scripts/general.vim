function! s:has_plugin(plugin)
  let lookup = 'g:plugs["' . a:plugin . '"]'
  return exists(lookup)
endfunction

highlight Pmenu guibg=white guifg=black gui=bold
highlight Comment gui=bold
highlight Normal gui=none
highlight NonText guibg=none
autocmd ColorScheme * highlight VertSplit cterm=NONE ctermfg=Green ctermbg=NONE

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

syntax enable    " enable syntax highlighting

set mouse=a                                             " enable mouse scrolling
set clipboard+=unnamed,unnamedplus                      " use system clipboard by default
" C-c and C-v - Copy/Paste to global clipboard
vmap <C-c> "+yi
imap <C-v> <esc>"+gpi

set listchars=eol:¬,tab:>-,trail:~,extends:>,precedes:<
set autoindent   " Copy indent from current line when starting a new line
set showcmd      " display incomplete commands
set showmode     " display the mode you're in
set backspace=indent,eol,start " intuitive backspacing"
set hidden       " Handle multiple buffers better
set wildmenu     " enhanced command line completion
set wildmode=list:longest " complete files like a shell

""" Search
set ruler        " show cursor position
set hlsearch     " highlight matches
set incsearch    " highlight matches as you type
set smartcase    " but case-sensitive if expression contains a capital letter
set ignorecase   " case-insensitive search

" No stuff
set nonumber
set noshowmode

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
set undolevels=100

" Indenting
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
let g:indentLine_char = '|'
autocmd BufRead * :IndentLinesEnable

" Tab switching
nnoremap <C-Tab> :bn<CR>