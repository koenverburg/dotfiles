let g:diagnostic_insert_delay = 1
let g:diagnostic_show_sign = 1
let g:diagnostic_enable_ale = 0
let g:diagnostic_enable_virtual_text = 1
let g:completion_enable_auto_paren = 1 " Complete parentheses for functions

let g:completion_confirm_key = "\<C-y>" " Work with vim-endwise
" Set completeopt to have a better completion experience
set completeopt=preview,menuone,noinsert,noselect
" Avoid showing message extra message when using completion
set shortmess+=c

"let g:completion_enable_snippet = 'UltiSnips'
"
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
let g:completion_trigger_character = ['.']

