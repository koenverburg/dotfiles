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
let g:airline#extensions#tabline#enabled = 1

"" WordJumping like with resharper
"imap <silent> <S-Left> <C-o><Plug>CamelCaseMotion_w
"imap <silent> <S-Right> <C-o><Plug>CamelCaseMotion_b

"map <silent> w <Plug>CamelCaseMotion_w
"map <silent> b <Plug>CamelCaseMotion_b
"map <silent> e <Plug>CamelCaseMotion_e
"map <silent> ge <Plug>CamelCaseMotion_ge
"sunmap w
"sunmap b
"sunmap e
"sunmap ge

" easy motion
map  <space>jf <Plug>(easymotion-bd-f)
nmap <space>jf <Plug>(easymotion-overwin-f)

" s{char}{char} to move to {char}{char}
nmap <space>js <Plug>(easymotion-overwin-f2)

" Move to line
map <space>jl <Plug>(easymotion-bd-jk)
nmap <space>jl <Plug>(easymotion-overwin-line)

" Move to word
map  <space>jw <Plug>(easymotion-bd-w)
nmap <space>jw <Plug>(easymotion-overwin-w)

nnoremap <space>b :Buffers<cr>

let g:DevIconsAppendArtifactFix = 1

set list

call cyclist#add_listchar_option_set('limited', {
        \ 'eol': '↲',
        \ 'tab': '» ',
        \ 'trail': '·',
        \ 'extends': '<',
        \ 'precedes': '>',
        \ 'conceal': '┊',
        \ 'nbsp': '␣',
        \ })

call cyclist#add_listchar_option_set('busy', {
        \ 'eol': '↲',
        \ 'tab': '»·',
        \ 'space': '␣',
        \ 'trail': '-',
        \ 'extends': '☛',
        \ 'precedes': '☚',
        \ 'conceal': '┊',
        \ 'nbsp': '·',
        \ })

nmap <leader>cl <Plug>CyclistNext

