:lua <<EOF
  require 'telescope'.setup {
    defaults = {
      prompt_position = "top",
      sorting_strategy = "ascending",
      borderchars = {"─", "│", "─", "│", "┌", "┐", "┘", "└"},
    }
  }
EOF

" --- set_env = { ['COLORTERM'] = 'truecolor' },

nnoremap <Leader>p <cmd>lua require'telescope.builtin'.git_files{}<CR>
nnoremap <A-t> <cmd>lua require'telescope.builtin'.find_files{}<CR>
nnoremap <A-F> <cmd>lua require'telescope.builtin'.live_grep{}<CR>
nnoremap <A-a> <cmd>lua require'telescope.builtin'.buffers{}<CR>

nnoremap <C-S>o <cmd>lua require'telescope.builtin'.git_files{}<CR>
nnoremap <Leader>dp :lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({}))<cr>

