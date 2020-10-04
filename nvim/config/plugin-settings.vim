" Indenting
let g:indentLine_enable = 0
let g:indentLine_setColors = 0
let g:indentLine_leadingSpaceEnabled = 1
let g:indentLine_char = '|'
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
let g:indentLine_fileTypeExclude = ['nerdtree']
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
  let g:ackprg = 'rg --vimgrep'
  nnoremap <leader>ff :Ack!
endif

let g:NERDTreeIgnore = ['^node_modules$', 'deps', '_build', '.elixir_ls']
let NERDTreeShowHidden = 1
let NERDTreeShowLineNumbers = 0

nnoremap <silent><C-p> :NERDTreeToggle<cr>
nnoremap <silent><leader>nf :NERDTreeFind<cr>

" Stealing this one from https://github.com/dduan/dotfiles/blob/master/nvim/init.vim#L150
" Close vim if the last window open is NerdTree
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Airline theme
let g:airline_theme = 'gruvbox'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

" WordJumping like with resharper
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

