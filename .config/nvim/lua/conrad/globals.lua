vim.o.ruler = true
vim.o.background = 'dark'

require('colorbuddy').colorscheme('nebulous')
require('nebulous').setup({
  variant = 'night',
  italic = {
    comments   = false,
    keywords   = false,
    functions  = false,
    variables  = false,
  }
})

vim.cmd [[ highlight NonText guibg=none ]]
vim.cmd [[ highlight Normal guibg=none ]]

vim.g.mapleader = ','
vim.b.mapleader = ','

vim.g.hidden = true
vim.g.nobackup= true
vim.b.noswapfile = true
vim.g.undofile = true
vim.g.undordir='~/.config/nvim/undodir'

vim.wo.number = true
vim.wo.relativenumber = false
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
vim.o.completeopt = 'menu,menuone,noselect,noinsert'
vim.o.backspace = 'indent,eol,start'

vim.o.inccommand = 'split'
vim.o.shortmess = vim.o.shortmess .. 'c'
vim.o.cmdheight = 1

vim.o.clipboard = vim.o.clipboard .. 'unnamed,unnamedplus'
vim.o.termguicolors = true
vim.o.showtabline = 2

vim.cmd [[ highlight clear SignColumn ]]
vim.cmd [[ set noshowmode ]]
