-- This file will contain all the keybindings for nvim
local utils = require "utils"
local normal = utils.normal
local visual = utils.visual
local insert = utils.insert
local terminal = utils.terminal

-- ----------------------------------------------------------------------------
--
-- Vim bindings
--
-- ----------------------------------------------------------------------------
-- normal("q", "NOP") -- turn of recording of macros
-- normal("G", "Gzz")

-- Swap : and ; to make colon commands easer to type
normal(";", ":")
normal(":", ";")

-- Quick folding
normal("<space>f", "za<cr>")

-- Rapid movement
normal("<s-a>", ":edit %:h<cr>")

-- Move whole lines, kudos @theprimeagen
visual("J", ":m '>+1<CR>gv=gv")
visual("K", ":m '<-2<CR>gv=gv")

-- Copy from cursor position to end of the line
normal("Y", "y$")

-- Concat lines below on current line
normal("J", "mzJ`z")

-- Undo until , .
insert(",", ",<c-g>u")
insert(".", ".<c-g>u")

-- This is so I can quickly quite out of vim without having to close all the buffers
-- normal("<leader>bd", "<cmd>qall<cr>") -- delete all buffers
normal("<leader>q", ":SaveSession<cr>|:qall<cr>")

-- Easier Moving between splits
normal("<C-j>", "<C-W><C-J>")
normal("<C-k>", "<C-W><C-K>")
normal("<C-l>", "<C-W><C-L>")
normal("<C-h>", "<C-W><C-H>")

-- Better jk
normal("j", "gj")
normal("k", "gk")

-- Faster moving from beginning to end of a line
normal("H", "^")
normal("L", "g_")

visual("H", "^")
visual("L", "g_")

-- Jumping from the beginning of a []{}() to the end
normal("<Tab>", "%")

-- Splits
normal("sh", ":sp<cr>|<c-w>j")
normal("sv", ":vsp<cr>|<c-w>l")
normal("<space>sh", ":sp<cr>|<c-w>j|:Telescope git_files<cr>")
normal("<space>sv", ":vsp<cr>|<c-w>l|:Telescope git_files<cr>")

-- Keep search matches in the middle of the window
normal("n", "nzzzv")
normal("N", "Nzzzv")

-- Quickly return to normal mode
insert("jk", "<esc>")

-- keep text selected after indentation
visual("<", "<gv")
visual(">", ">gv")

-- quickly cancel search highlighting
normal("<leader><space>", ":nohl<cr>")

-- Faster saving
-- normal('<leader>w', ':w<cr>')
-- insert('<leader>w', ':w<cr>')

-- Creating a new tab
normal("<leader>T", ":tabnew<cr>")

-- Tab movement
normal("<S-Tab>", ":tabnext<cr>")

normal('<space>', 'za')
-- Credo, sort aliases in alphabetical order
-- visual("<leader>s", ":'<,'>!sort -f<cr>")

-- ----------------------------------------------------------------------------
--
-- Plugins bindings
--
-- ----------------------------------------------------------------------------

-- Searching
normal('<leader>S', [[ <cmd>lua require('spectre').open()<cr> ]])
normal('<leader>sw', [[ <cmd>lua require('spectre').open_visual({ select_word=true })<cr> ]])
visual('<leader>s', [[ <esc>:lua require('spectre').open_visual()<cr> ]])
normal('<leader>sp', [[ viw:lua require('spectre').open_file_search()<cr> ]])

-- sessions
-- normal("<leader>ss", ":SSave<cr>")
-- normal("<leader>sc", ":SClose<cr>")

-- File Tree
normal("<C-b>", ":NvimTreeToggle<cr>")

normal("<leader>gt", [[ <cmd>lua require('lspsaga.floaterm').open_float_terminal()<cr> ]])
terminal("<leader>gt", [[ <c-\><c-n>:lua require('lspsaga.floaterm').close_float_terminal()<cr> ]])

normal("<leader>gg", [[ <cmd>Neogit<cr> ]])

-- -- Focus mode
-- normal("<leader><space>f", ":ZenMode<cr>")
-- normal("<leader><space>ll", ":Twilight<cr>")

-- Commenting
normal("<space>C", [[ <cmd>lua require('nvim-comment-frame').add_multiline_comment()<cr> ]])
-- normal(',fa', '<cmd>ComAnnotation<cr>')
-- visual("<space>c", "<cmd>Commentary<cr>")

-- word hopping
normal("<leader>jf", ":HopWord<cr>")

-- Toggle Alternate
normal("<leader>ta", ":ToggleAlternate<cr>")

-- Refactoring
normal("<leader>rd", [[ :lua require('refactoring').debug.printf({ below = true })<cr> ]])

-- Focus
normal("<leader>z", [[ <cmd>lua require'centerpad'.toggle { leftpad = 36, rightpad = 36 }<cr> ]])

-- Harpoon
-- normal("<c-m>", '<cmd>lua require("harpoon.mark").add_file()<cr>')
-- normal("<c-f>", '<cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>')
-- normal("<c-a>", '<cmd>lua require("harpoon.ui").nav_file(1)<cr>')

-- ----------------------------------------------------------------------------
--
-- My plugins bindings
--
-- ----------------------------------------------------------------------------

normal("<space>/", "<cmd>lua require('utils').PopUpSearch()<cr>")
-- normal('<Leader>T', [[ <cmd>lua require'lsp_extensions'.inlay_hints()<cr> ]])

-- Command Palette
normal("<space>cp", "<cmd>CmdPalette<cr>")

-- Find 'n Replace
normal("<leader>fr", ":%s/")
visual("<leader>fr", "'>s/")

normal("<leader><leader>x", "<cmd>lua require'utils'.save_and_execute()<cr>")
-- normal("<leader><leader>c", "<cmd>lua require'core.virtualtext'.show()<cr>")

-- Folding using Treesitter
normal("<leader>fi", "<cmd>lua require 'conrad.folds'.main()<cr>")

vim.cmd [[ autocmd WinEnter,WinLeave * :lua require'utils'.hideTablineWhenSingleTab() ]]

