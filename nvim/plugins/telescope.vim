:lua <<EOF
  require('telescope').setup {
    defaults = {
      prompt_position = "top",
      sorting_strategy = "ascending",
      color_devicons = true,
      borderchars = {"─", "│", "─", "│", "┌", "┐", "┘", "└"},
      --- set_env = { ['COLORTERM'] = 'truecolor' },
    }
  }
EOF

nnoremap <Leader>p <cmd>lua require'telescope.builtin'.git_files{}<CR>
nnoremap <A-t> <cmd>lua require'telescope.builtin'.find_files{}<CR>
nnoremap <A-F> <cmd>lua require'telescope.builtin'.live_grep{}<CR>
nnoremap <A-B> <cmd>lua require'telescope.builtin'.buffers{}<CR>

nnoremap <C-S>o <cmd>lua require'telescope.builtin'.git_files{}<CR>
nnoremap <Leader>dp :lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({}))<cr>

