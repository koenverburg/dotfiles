" .My Vimrc
" Author: Koen Verburg <creativekoen@gmail.com>
" Source: https://github.com/koenverburg/dotfiles
" Rewrite date 20 March 2020

let g:plugin_dir = expand('~/.config/nvim/plugins')

call plug#begin(g:plugin_dir)

" Colorscheme
Plug 'morhetz/gruvbox'
Plug 'altercation/vim-colors-solarized'
Plug 'ayu-theme/ayu-vim'

" Move to and from Tmux panes and Vim panes
Plug 'christoomey/vim-tmux-navigator'

" Language Support
Plug 'elixir-editors/vim-elixir'
Plug 'mhinz/vim-mix-format'
"Plug 'slashmili/alchemist.vim'

" Airline themes
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Git feedback in files
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" Convenience for commenting things in and out
Plug 'scrooloose/nerdcommenter'

" File tree
Plug 'scrooloose/nerdtree'

" Auto close parens, braces, brackets, etc
Plug 'jiangmiao/auto-pairs'

" Fuzzy finder
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

" Find in files
Plug 'mileszs/ack.vim'
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


set ignorecase
set smartcase

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

" Automatic indentation because I'm not going to do that myself
set autoindent

" Undo function after reopening
set undofile
set undodir=/tmp

" accelerated scrolling
set scrolljump=-15

" See help fo
set formatoptions=qrnj1

" This is for etter vertial movement for wrapped lines
" Dont like wrapped lines but sometimes you have to wrapped it
nnoremap j gj
nnoremap k gk

" Faster moving from beginning to end of a line
noremap H ˆ
noremap L g_

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

" Faster saving
inoremap <leader>w :w<cr>
nnoremap <leader>w :w<cr>


" quickly cancel search highlighting
nnoremap <leader><space> :nohlsearch<cr>

" Credo wants this, sort aliases in alphabetical order
vnoremap <leader>s :'<,'>!sort -f<cr>

" Quickly insert a timestamp
nnoremap tt "=strftime("%F %T%z")<CR>p

" Toggle quickfix windown
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

" Colorscheme setting for in the terminal
" let g:solarized_termcolors=256

nnoremap <leader>gs :Gstatus<cr>

" FZF
if executable('fzf')
    nnoremap <leader>t :FZF<cr>
endif


" [mileszs/ack.vim]
if executable('rg')
  let g:ackprg = '/usr/local/bin/rg --vimgrep'
  nnoremap <leader>ff :Ack!
endif


let g:NERDTreeIgnore = ['^node_modules$', 'deps', '_build', '.elixir_ls']
let NERDTreeShowHidden = 1
let NERDTreeShowLineNumbers = 0

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
