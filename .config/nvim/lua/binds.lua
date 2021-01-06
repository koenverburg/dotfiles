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
normal('<A-j>', '<C-W><C-J>')
normal('<A-k>', '<C-W><C-K>')
normal('<A-l>', '<C-W><C-L>')
normal('<A-h>', '<C-W><C-H>')

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

-- list buffers
normal('<space>b', ':Buffers<cr>')

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
normal('/', '/\v')
visual('/', '/\v')

-- Replace
normal('<C-r>', ":%s/")
visual('<C>rr', ":<,'>s/")

-- Swap : and ; to make colon commands easer to type
normal(';', ':')
normal(':', ';')

-- FZF
normal('<leader>t', ':FZF<cr>')
normal('<space>ff', ':Rg')

-- What is time?>
normal('tt', '"=strftime("%F %T%z")<CR>')

return {
  normal,
  visual,
  insert
}
