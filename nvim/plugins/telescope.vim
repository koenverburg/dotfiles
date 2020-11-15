 :lua <<EOF
 require('telescope').setup {
   defaults = {
     borderchars = {"─", "│", "─", "│", "┌", "┐", "┘", "└"},
   }
 }
EOF

nnoremap <Leader>p <cmd>lua require'telescope.builtin'.git_files{}<CR>
nnoremap <A-t> <cmd>lua require'telescope.builtin'.find_files{}<CR>
nnoremap <A-F> <cmd>lua require'telescope.builtin'.live_grep{}<CR>
nnoremap <A-B> <cmd>lua require'telescope.builtin'.buffers{}<CR>

nnoremap <C-S>o <cmd>lua require'telescope.builtin'.git_files{}<CR>
nnoremap <Leader>dp :lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({}))<cr>

