" Indenting
"let g:indentLine_enable = 0
"let g:indentLine_setColors = 0
"let g:indentLine_leadingSpaceEnabled = 1
"let g:indentLine_char = '|'
"let g:indentLine_char_list = ['|', '¦', '┆', '┊']
"let g:indentLine_fileTypeExclude = ['nerdtree']
"let g:indent_guides_exclude_filetypes = ['nerdtree']
"autocmd BufRead * :IndentLinesEnable

" View json properly
" let g:vim_json_syntax_conceal = 0


augroup illuminate_augroup
    autocmd!
    autocmd VimEnter * hi illuminatedWord cterm=underline gui=underline
augroup END


" Git shortcuts
nnoremap <leader>gs :Gstatus<cr>

" Airline theme
let g:airline_theme = 'minimalist'
let g:airline_powerline_fonts = 0
let g:airline#extensions#tabline#enabled = 0

" WordJumping like with resharper
imap <silent> <S-Left> <C-o><Plug>CamelCaseMotion_w
imap <silent> <S-Right> <C-o><Plug>CamelCaseMotion_b

map <silent> w <Plug>CamelCaseMotion_w
map <silent> b <Plug>CamelCaseMotion_b
map <silent> e <Plug>CamelCaseMotion_e
map <silent> ge <Plug>CamelCaseMotion_ge
sunmap w
sunmap b
sunmap e
sunmap ge

