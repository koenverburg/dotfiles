" .My Vimrc
" Author: Koen Verburg <creativekoen@gmail.com>
" Source: https://github.com/koenverburg/dotfiles
" Rewrite date 20 March 2020

let g:plugin_dir = expand('~/.config/nvim/plugins')

call plug#begin(g:plugin_dir)

" Colorscheme
Plug 'morhetz/gruvbox'
Plug 'rakr/vim-one'

" Move to and from Tmux panes and Vim panes
Plug 'christoomey/vim-tmux-navigator'

" Language Support
Plug 'elixir-editors/vim-elixir'
Plug 'mhinz/vim-mix-format'
Plug 'elzr/vim-json'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'othree/yajs.vim'
Plug 'herringtondarkholme/yats.vim'

"Plug 'slashmili/alchemist.vim'

" Airline themes
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Git feedback in files
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" Able to change '"[{()}]
Plug 'tpope/vim-surround'

" Convenience for commenting things in and out
Plug 'scrooloose/nerdcommenter'

" File tree
Plug 'scrooloose/nerdtree'

" Auto close parens, braces, brackets, etc
Plug 'jiangmiao/auto-pairs'

" Fuzzy finder
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

" Linting error support for js,ts and elixir
Plug 'desmap/ale-sensible'
Plug 'w0rp/ale', { 'for': ['typescript', 'javascript'] }

" Find in files
Plug 'mileszs/ack.vim'

" View indenting
Plug 'Yggdroot/indentLine'

" add the 'end' to def methods, this if for elixir
Plug 'tpope/vim-endwise'

" WordJumping like resharper
Plug 'bkad/CamelCaseMotion'

call plug#end()

set background=dark
colorscheme gruvbox

let mapleader = ","

set mouse=a "scrolling in tmux
set title

set list
set listchars=eol:¬,tab:>-,trail:~,extends:>,precedes:<

" Save a file when focus is lost
au FocusLost * :wa

" use system clipboard by default
set clipboard+=unnamed,unnamedplus                      " use system clipboard by default

" Viewing folders and files
set wildmode=list:longest,full

" Highlight the line where the cursor is on
set cursorline

" Show cursor position
set ruler

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" read/write file when switching buffers
set autowrite
set autoread

" tab settings
set shiftwidth=2
set tabstop=2
set softtabstop=2
set expandtab
set smarttab
set ignorecase
set smartcase

" Automatic indentation because I'm not going to do that myself
set autoindent

" Undo function after reopening
set undofile
set undodir=/tmp

" accelerated scrolling
set scrolljump=-15

set number

" See help fo
set formatoptions=qrnj1

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

" MAPPINGS

" This is for etter vertial movement for wrapped lines
" Dont like wrapped lines but sometimes you have to wrapped it
nnoremap j gj
nnoremap k gk

" Faster moving from beginning to end of a line
nnoremap H ^
nnoremap L g_

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

" Tab Switching (shift+{t,h,l})
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

" PLUGIN Settings

" Indenting
let g:indentLine_enable = 0
let g:indentLine_setColors = 0
let g:indentLine_leadingSpaceEnabled = 1
let g:indentLine_char = '|'
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
let g:indentLine_fileTypeExclude = ["nerdtree"]
let g:indent_guides_exclude_filetypes = ['nerdtree']
autocmd BufRead * :IndentLinesEnable

" View json properly
let g:vim_json_syntax_conceal = 0

" Git shortcuts
nnoremap <leader>gs :Gstatus<cr>

" FZF
if executable('fzf')
  nnoremap <leader>t :FZF<cr>
endif

" Find in files
if executable('rg')
  let g:ackprg = '/usr/local/bin/rg --vimgrep'
  nnoremap <leader>ff :Ack!
endif

let g:NERDTreeIgnore = ['^node_modules$', 'deps', '_build', '.elixir_ls']
let NERDTreeShowHidden = 1
let NERDTreeShowLineNumbers = 0

nnoremap <silent><leader>nn :NERDTree<cr>
nnoremap <silent><leader>a :NERDTreeToggle<cr>
inoremap <silent><leader>a :NERDTreeToggle<cr>

" Stealing this one from https://github.com/dduan/dotfiles/blob/master/nvim/init.vim#L150
" Close vim if the last window open is NerdTree
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Airline theme
let g:airline_theme = 'gruvbox'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

" Mix formatting
let g:mix_format_on_save = 1

" WordJumping like which resharper
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
