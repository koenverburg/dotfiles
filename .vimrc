set nocompatible
filetype off

"git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim


set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

Plugin 'gmarik/Vundle.vim'

"env
Plugin 'tpope/vim-rails'
Plugin 'moll/vim-node'
Plugin 'mattn/emmet-vim' " ctrl y ,
    let g:user_emmet_install_global = 0
    let g:user_emmet_mode='a'
    autocmd FileType html,css EmmetInstall

"Plugin 'emmetio/emmet'

" complete
Plugin 'myhere/vim-nodejs-complete'
Plugin 'shawncplus/phpcomplete.vim'
"Plugin 'm2mdas/phpcomplete-extended'
    "autocmd  FileType  php setlocal omnifunc=phpcomplete_extended#CompletePHP
    "let g:SuperTabDefaultCompletionType = "<c-x><c-o>"

"hightlight
Plugin 'sickill/vim-monokai'
Plugin 'ap/vim-css-color'
Plugin 'altercation/vim-colors-solarized'

"CODE hightligh
Plugin 'jelera/vim-javascript-syntax'
Plugin 'digitaltoad/vim-jade'
Plugin 'wavded/vim-stylus'
Plugin 'kchmck/vim-coffee-script'
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-markdown'

"basic html/web
Plugin 'StanAngeloff/php.vim'

"python/C#/C/C++
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'bps/vim-textobj-python'

" VIM INTERFACE
Plugin 'scrooloose/syntastic'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'tpope/vim-commentary'
    autocmd FileType apache set commentstring=#\ %s
    "select with v and comment with gc
Plugin 'tpope/vim-surround'

Plugin 'kien/ctrlp.vim'
Plugin 'airblade/vim-gitgutter'

Plugin 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
    nnoremap <silent> <F4> :NERDTreeToggle<CR>
    nnoremap <silent> <F5> :NERDTreeFind<CR>
    "autocmd VimENter * NERDTree
    "autocmd VimENter * wincmd p
Plugin 'bling/vim-airline'

    let g:airline_theme='powerlineish'

    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#left_alt_sep = '|'
Plugin 'tpope/vim-fugitive'
Plugin 'junegunn/limelight.vim'
    nmap <Leader>l <Plug>(Limelight)

"Plugin 'konfekt/fastfold'

"snippets
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'SirVer/ultisnips'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'

call vundle#end()



" set stuff
set number
set splitright splitbelow
filetype plugin indent on
syntax on
colorscheme solarized
set background=dark
set encoding=utf-8
set laststatus=2
set lazyredraw
set hidden
set backspace=2
set backspace=indent,eol,start


if has("gui_running")
  if has("gui_macvim")
    set guifont=Consolas:h15
    "set guifont=Anonymice\ Powerlines:h15
  elseif has("gui_win32")
    "autocmd GUIEnter * simalt ~x " open maximize in Windows
    set guifont=Consolas:h11
    set lines=35 columns=100
    "set guifont=Anonymice_Powerlines:h11
    "set guifont=Sause_Code_Powerline_Lights:h11
  endif
  set guioptions= " disable all UI options
  set guicursor+=a:blinkon0 " disable blinking cursor
  set ballooneval
  autocmd GUIEnter * set visualbell t_vb=
else
  set noerrorbells visualbell t_vb=
  if !s:is_nvim
    set term=xterm
  endif
  set t_ut= " setting for looking properly in tmux
  set t_ti= t_te= " prevent vim from clobbering the scrollback buffer
  let &t_Co = 256
  if s:is_windows " trick to support 256 colors and scroll in conemu
    let &t_AF="\e[38;5;%dm"
    let &t_AB="\e[48;5;%dm"
    inoremap <esc>[62~ <c-x><c-e>
    inoremap <esc>[63~ <c-x><c-y>
    nnoremap <esc>[62~ 3<c-e>
    nnoremap <esc>[63~ 3<c-y>
  endif
endif

"airline settings
function! AirlineInit()
let g:airline_right_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_left_alt_sep= ''
let g:airline_left_sep = ''
    let g:airline_section_a = airline#section#create(['mode',' ','branch'])
    let g:airline_section_b = airline#section#create_left(['ffenc','hunks ','%f'])
    let g:airline_section_c = airline#section#create(['filetype'])

    let g:airline_section_x = airline#section#create(['%P'])
    let g:airline_section_y = airline#section#create(['%B'])
    let g:airline_section_z = airline#section#create_right(['%l','%c'])
endfunction
autocmd VimEnter * call AirlineInit()

"Au BufWritePost .vimrc so ~/.vimrc
" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags



"""""""""""""""""
"
" Custom macro's
"
"""""""""""""""""

map <Leader>tn :tabnew<CR>
map <Leader>to :tabonly<CR>
map <Leader>tc :tabclose<CR>
map <Leader>tn :tabnew<CR>
map <Leader>tm :tabmove<CR>


