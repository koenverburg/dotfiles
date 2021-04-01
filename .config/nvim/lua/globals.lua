vim.o.ruler = true
vim.o.background = 'dark'
vim.g.gruvbox_italic = 0
vim.cmd('colorscheme gruvbox')

vim.g.mapleader = ','
vim.b.mapleader = ','

vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.wrap = false
vim.wo.list = true

vim.o.tabstop = 2
vim.bo.tabstop = 2

vim.o.softtabstop = 2
vim.bo.softtabstop = 2

vim.o.shiftwidth = 2
vim.bo.shiftwidth = 2

vim.o.autoindent = true
vim.bo.autoindent = true

vim.o.expandtab = true
vim.bo.expandtab = true

vim.o.autoindent = true
vim.bo.autoindent = true

vim.cmd('language en_US.utf-8')

vim.o.termguicolors = true
vim.o.completeopt = 'preview,menuone,noinsert,noselect,'
vim.o.backspace = 'indent,eol,start'

vim.o.inccommand = 'split'
vim.o.shortmess = vim.o.shortmess .. 'c'
vim.o.cmdheight = 1

vim.o.clipboard = vim.o.clipboard .. 'unnamed,unnamedplus'
vim.o.termguicolors = true
vim.o.showtabline = 2
--vim.o.equalalways = true -- Auto-resize windows

vim.cmd [[ highlight clear SignColumn ]]