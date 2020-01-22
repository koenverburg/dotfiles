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
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'desmap/ale-sensible' | Plug 'w0rp/ale', { 'for': ['typescript', 'javascript'] }
Plug 'bkad/CamelCaseMotion'

" search
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all', 'for': ['elixir', 'typescript'] }
Plug 'junegunn/fzf.vim', { 'for': ['elixir', 'typescript'] }
Plug 'mileszs/ack.vim', { 'for': ['elixir', 'typescript'] }
" Plug 'kien/ctrlp.vim'
" snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'                               " actual snippets

" visual
Plug 'alvan/vim-closetag'                               " auto close html tags
Plug 'Yggdroot/indentLine'                              " show indentation lines
Plug 'google/vim-searchindex'                           " add number of found matching search items

" languages
Plug 'sheerun/vim-polyglot'                             " many languages support
Plug 'tpope/vim-liquid'                                 " liquid language support
Plug 'elzr/vim-json'

" other
Plug 'tpope/vim-commentary'                             " better commenting
Plug 'tpope/vim-sensible'                               " sensible defaults
Plug 'tpope/vim-fugitive'                               " git support
Plug 'tpope/vim-surround'                               " surround stuff with stuff
" Plug '907th/vim-auto-save'                              " auto save changes
Plug 'psliwka/vim-smoothie'                             " some very smooth ass scrolling
Plug 'farmergreg/vim-lastplace'                         " open files at the last edited place
Plug 'romainl/vim-cool'                                 " disable hl until another search is performed
" Plug 'wellle/tmux-complete.vim'                         " complete words from a tmux panes
Plug 'majutsushi/tagbar', { 'for': ['python'] }
Plug 'liuchengxu/vista.vim', { 'for': ['elixir', 'python'] }
" Zen
" Plug 'junegunn/goyo.vim'
" Plug 'junegunn/limelight.vim'
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

highlight Pmenu guibg=white guifg=black gui=bold
highlight Comment gui=bold
highlight Normal gui=none
highlight NonText guibg=none
autocmd ColorScheme * highlight VertSplit cterm=NONE ctermfg=Green ctermbg=NONE

" ==================== general config ======================== "

set termguicolors                                       " Opaque Background
set mouse=a                                             " enable mouse scrolling
set clipboard+=unnamed,unnamedplus                      " use system clipboard by default
" C-c and C-v - Copy/Paste to global clipboard
vmap <C-c> "+yi
imap <C-v> <esc>"+gpi
" ===================== Other Configurations ===================== "

filetype plugin indent on                               " enable indentations
set incsearch ignorecase smartcase hlsearch             " highlight text while seaching
set background=dark
"set list listchars=trail:»,tab:»-                       " use tab to navigate in list mode
"exec "set listchars=tab:▸\ ,trail:\uB7,nbsp:~,eol:¬
"set listchars=tab:▸\ ,eol:¬,trail:-
set listchars=eol:¬,tab:>-,trail:~,extends:>,precedes:<
set list
set fillchars+=vert:\▏                                  " requires a patched nerd font (try furaCode)
set wrap breakindent                                    " wrap long lines to the width sset by tw
set encoding=utf-8                                      " text encoding
set number                                              " enable numbers on the left
set title                                               " tab title as file file
set conceallevel=2                                      " set this so we womt break indentation plugin
set splitright                                          " open vertical split to the right
set splitbelow                                          " open horizontal split to the bottom
set tw=80                                               " auto wrap lines that are longer than that
set emoji                                               " enable emojis
let g:indentLine_setConceal = 0                         " actually fix the annoying markdown links conversion
au BufEnter * set fo-=c fo-=r fo-=o                     " stop annying auto commenting on new lines
set undofile                                            " enable persistent undo
set undodir=~/.nvim/tmp                                 " undo temp file directory
set ttyfast                                             " faster scrolling
set lazyredraw                                          " faster scrolling
set nonumber
" Leader
let mapleader = ","
let maplocalleader = "\\"

call rpcnotify(1, 'Gui', 'Option', 'Tabline', 0)

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

" plugin setting ----------------------------------------------------------- {{{

  let g:indentLine_enabled = 0
  let g:indentLine_setColors = 0
  let g:indentLine_leadingSpaceEnabled = 1

  let g:EditorConfig_exec_path = 'editorconfig'

  " Json
  let g:vim_json_syntax_conceal = 0                                             " I want to see the quote's

  " Airline
  let g:airline_theme = 'gruvbox'
  let g:airline#extensions#tabline#enabled = 1

  set signcolumn=yes
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

  nnoremap <silent> <F4> :NERDTreeToggle<cr>
  inoremap <silent> <F4> :NERDTreeToggle<cr>

  nnoremap <silent> <F5> :NERDTreeFind<cr>
  inoremap <silent> <F5> :NERDTreeFind<cr>

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
  "   " \ 'php': 'vim_lsp',
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

" Nvim terminal ------------------------------------------------------------ {{{

  au BufEnter * if &buftype == 'terminal' | :startinsert | endif
  autocmd BufEnter term://* startinsert
  autocmd TermOpen * set bufhidden=hide

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
