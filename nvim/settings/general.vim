set background=dark
let g:nvcode_termcolors=256

colorscheme palenight

let mapleader = ","

set mouse=a "scrolling in tmux
set title

set list
set listchars=eol:¬,tab:>-,trail:~,extends:>,precedes:<

set inccommand=split

" Save a file when focus is lost
au FocusLost * :wa

" use system clipboard by default
set clipboard+=unnamed,unnamedplus                      " use system clipboard by default

" Viewing folders and files
set wildmode=list:longest,full

set number
set relativenumber
set ruler " Show cursor position
set cursorline " Highlight the line where the cursor is on

highlight clear SignColumn  " SignColumn should match background

set backspace=indent,eol,start " allow backspacing over everything in insert mode

" read/write file when switching buffers
set autowrite
set autoread

" tab settings
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set smarttab
set ignorecase
set smartcase

" Automatic indentation because I'm not going to do that myself
set autoindent

set hidden
" set nobackup
" set noswapfile

" accelerated scrolling
set scrolljump=-15

" Give more space for displaying messages.
set cmdheight=1

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

set formatoptions=qrnj1 " See help fo

" No idea what this does
set report=2       " Always report changed lines
set linespace=0    " No extra spaces between rows
set pumheight=20   " Avoid the pop up menu occupying the whole screen

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

set colorcolumn=81
hi ColorColumn ctermbg=green
call matchadd('ColorColumn', '\%81v', 100)
