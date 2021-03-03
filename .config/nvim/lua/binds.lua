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

-- Easier Moving between splits
normal('<C-j>', '<C-W><C-J>')
normal('<C-k>', '<C-W><C-K>')
normal('<C-l>', '<C-W><C-L>')
normal('<C-h>', '<C-W><C-H>')
-- alt version
--normal('<A-j>', '<C-W><C-J>')
--normal('<A-k>', '<C-W><C-K>')
--normal('<A-l>', '<C-W><C-L>')
--normal('<A-h>', '<C-W><C-H>')

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

-- utils?
-- TODO find a better name for these things

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

-- sain undo and redo
normal('<C-z>', '<Esc>')
normal('<C-y>', '<Esc><C-r>')

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
