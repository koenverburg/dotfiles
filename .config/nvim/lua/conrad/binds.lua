-- This file will contain all the keybindings for nvim
local utils         = require('conrad.utils')
local normal        = utils.normal
local visual        = utils.visual
local insert        = utils.insert
local terminal      = utils.terminal
local telescope_map = utils.telescope_map

telescope_map('<space>gw', 'get_worktrees')
telescope_map('<space>cwt', 'create_worktree')

telescope_map('<leader><space>h', 'help_tags')

telescope_map('<space>ff', 'find_files')
telescope_map('<space>fg', 'live_grep_custom')
-- telescope_map('<space>fd', 'grep_string')
telescope_map('<space>fc', 'get_frecency')
-- TODO Needs to focus on the file not open in the current buffer
--telescope_map('<space>fb', 'buffers')

telescope_map('<space>t' , 'git_files')
telescope_map('<space>ed' , 'find_files_dotfiles')

-- lsp
telescope_map('<leader>fr', 'lsp_references')
telescope_map('<c-d>', 'lsp_document_symbols')

normal('<leader><leader>x', "<cmd>lua require'conrad.utils'.save_and_execute()<cr>")
normal('<leader><leader>c', "<cmd>lua require'conrad.plugins.complexity'.foo()<cr>")

-- normal('<leader>vt', "<cmd>lua require'conrad.core.virtualtext'.show()<cr>")
vim.api.nvim_command [[ autocmd CursorMoved * :lua require 'conrad.core.virtualtext'.show() ]]
vim.api.nvim_command [[ autocmd CursorMovedI * :lua require 'conrad.core.virtualtext'.show() ]]

-- Easier Moving between splits
normal('<C-j>', '<C-W><C-J>')
normal('<C-k>', '<C-W><C-K>')
normal('<C-l>', '<C-W><C-L>')
normal('<C-h>', '<C-W><C-H>')

-- Better jk
normal('j', 'gj')
normal('k', 'gk')

-- Faster moving from beginning to end of a line
normal('H', '^')
normal('L', 'g_')

visual('H', '^')
visual('L', 'g_')

-- Jumping from the beginning of a []{}() to the end
normal('<Tab>', '%')

-- Keep search matches in the middle of the window
normal('n', 'nzzzv')
normal('N', 'Nzzzv')

-- Git shortcuts
normal('<leader>gs', ':Gstatus<cr>')

-- Quickly return to normal mode
insert('jk', '<esc>')

-- keep text selected after indentation
visual('<', '<gv')
visual('>', '>gv')

-- Searching
-- quickly cancel search highlighting
normal('<leader><space>', ':nohl<cr>')

-- window resizing
normal('<c-left>', '5<c-w>>')
normal('<c-right>', '5<c-w><')
normal('<c-up>', ':resize +5<cr>')
normal('<c-down>', ':resize -5<cr>')

-- Faster saving
-- normal('<leader>w', ':w<cr>')
-- insert('<leader>w', ':w<cr>')

-- Creating a new tab
normal('<leader><S-t>', ':tabnew<cr>')

-- Credo, sort aliases in alphabetical order
visual('<leader>s', ":'<,'>!sort -f<cr>")

-- Searching
normal('/', '/\v')
visual('/', '/\v')

-- Replace
normal('<leader>rr', ":%s/")

-- Swap : and ; to make colon commands easer to type
normal(';', ':')
normal(':', ';')

-- sessions
normal('<leader>ss', ':SSave<cr>')
normal('<leader>sc', ':SClose<cr>')

-- Move whole lines, kudos @theprimeagen
visual('J', ":m '>+1<CR>gv=gv")
visual('K', ":m '<-2<CR>gv=gv")

normal('<C-b>', ':NERDTreeToggle<cr>')

normal('<leader>gg', [[ <cmd>lua require('lspsaga.floaterm').open_float_terminal('lazygit')<cr> ]])
terminal('<leader>gg', [[ <c-\><c-n>:lua require('lspsaga.floaterm').close_float_terminal()<cr> ]])

-- Focus mode
normal('<leader><space>f', ':ZenMode<cr>')
normal('<leader><space>ll', ':Twilight<cr>')

-- Commenting
normal('<space>dc', ':ProDoc<cr>')
normal('<space>c', ':Commentary<cr>')
visual('<space>c', ':Commentary<cr>')

-- word hopping
normal('<leader>mv', ':HopWord<cr>')

-- Toggle Alternate
normal('<leader>ta', ':ToggleAlternate<cr>')

-- Formatting
-- normal('<leader>f', ':Format<cr>')

-- Refactoring
visual('<Leader>re', [[ <Cmd>lua require('refactoring').refactor('Extract Function')<CR> ]])

-- normal('<leader>gg', ':Neogit<cr>')

return {
  normal,
  visual,
  insert
}
