:lua <<EOF
  require 'telescope'.setup {
    defaults = {
      winblend = 0,
      preview_cutoff = 120,

      prompt_position = "top",
      scroll_strategy = 'cycle',
      layout_strategy = 'horizontal',
      sorting_strategy = "ascending",
      color_devicons = true,

      layout_defaults = {
        horizontal = {
          width_padding = 0.1,
          height_padding = 0.1,
          preview_width = 0.6,
        },
        vertical = {
          width_padding = 0.05,
          height_padding = 1,
          preview_height = 0.5,
        }
      },

      borderchars = {"─", "│", "─", "│", "┌", "┐", "┘", "└"},
    }
  }
EOF

" --- set_env = { ['COLORTERM'] = 'truecolor' },

nnoremap <Leader>p <cmd>lua require'telescope.builtin'.git_files{}<CR>
nnoremap <A-a> <cmd>lua require'telescope.builtin'.buffers{}<CR>
nnoremap <A-t> <cmd>lua require'telescope.builtin'.find_files{}<CR>

nnoremap <Leader>dp :lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({}))<cr>

