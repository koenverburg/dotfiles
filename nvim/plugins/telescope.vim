" :lua <<EOF
" -- totally optional to use setup
" require('telescope').setup {
"   defaults = {
"     shorten_path = false -- currently the default value is true
"   }
" }
" EOF

nnoremap <Leader>p <cmd>lua require'telescope.builtin'.git_files{}<CR>
nnoremap <A-t> <cmd>lua require'telescope.builtin'.find_files{}<CR>
nnoremap <A-F> <cmd>lua require'telescope.builtin'.live_grep{}<CR>

nnoremap <C-S>o <cmd>lua require'telescope.builtin'.git_files{}<CR>
