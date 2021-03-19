-- This file will contain all the keybindings for nvim
local bind = function(mode, key, func)
  vim.api.nvim_set_keymap(mode, key, func, {noremap = true, silent = true})
end

local normal = function(key, func)
  bind('n', key, func)
end

local visual = function(key, func)
  bind('v', key, func)
end

local insert = function(key, func)
  bind('i', key, func)
end

local terminal = function(key, func)
  bind('t', key, func)
end

normal('<leader><leader>x', [[ <cmd>lua require('utils').save_and_execute()<CR> ]])

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
insert('jj', '<esc>')

-- keep text selected after indentation
visual('<', '<gv')
visual('>', '>gv')

-- Searching
-- quickly cancel search highlighting
normal('<leader><space>', ':nohl<cr>')

-- Quiting and saving
-- window resizing
normal('<c-left>', '5<c-w>>')
normal('<c-right>', '5<c-w><')

-- Faster saving
normal('<leader>w', ':w<cr>')
insert('<leader>w', ':w<cr>')

-- Remove whitespace
--[[normal('<leader>sws', ":%s/\s\+$//<cr>")]]

-- Creating a new tab
normal('<leader><S-t>', ':tabnew<cr>')

-- Credo wants this, sort aliases in alphabetical order
visual('<leader>s', ":'<,'>!sort -f<cr>")

-- Searching
normal('?', '?\v')
normal('/', '/\v')
visual('/', '/\v')

-- Replace
normal('<leader>r', ":%s/")
visual('<leader>rr', ":<,'>s/")

-- Swap : and ; to make colon commands easer to type
normal(';', ':')
normal(':', ';')

-- sessions
normal('<leader>ss', ':SSave<cr>')
normal('<leader>sc', ':SClose<cr>')

-- Move whole lines
visual('J', ":m '>+1<CR>gv=gv")
visual('K', ":m '<-2<CR>gv=gv")

normal('<C-b>', ':NERDTreeToggle<cr>')

normal('<A-d>', [[ <cmd>lua require('lspsaga.floaterm').open_float_terminal('pwsh')<cr> ]])
normal('<A-l>', ':Lspsaga open_floaterm lazygit<cr>')
terminal('<A-d>', [[ <c-\><c-n>:lua require('lspsaga.floaterm').close_float_terminal()<cr> ]])

-- focus mode with Goyo and limelight
normal('<leader>gy', ':Goyo 120<cr>')

-- Open a Markdown File in Typora
normal('<leader>tmp', [[ :call jobstart('typora '.. expand('%:p'))<cr> ]])

-- unsure about the bindings, thinking mvp
normal('pg', ':res +5<cr>')
normal('ps', ':res -5<cr>')

-- easymotion
--normal('<space>jf', '<Plug>(easymotion-overwin-f)')
--vim.cmd [[ map <space>jf <Plug>(easymotion-bd-f) ]]
-- two character search
normal('<space>js', '<Plug>(easymotion-overwin-f2)')
vim.cmd [[ map <space>js <Plug>(easymotion-bd-f2) ]]

-- Move to line
--normal('<space>jl', '<Plug>(easymotion-overwin-line)')
--vim.cmd [[ map <space>jl <Plug>(easymotion-bd-line) ]]
-- Move to word
--normal('<space>jw', '<Plug>(easymotion-overwin-w)')
--vim.cmd [[ map <space>jw <Plug>(easymotion-bd-w) ]]

return {
  normal,
  visual,
  insert,
  toggleLines
}
