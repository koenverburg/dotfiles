vim.g.mapleader = ","

local opt = vim.opt
local cache_dir = vim.env.HOME .. '/.cache/nvim/'

opt.autoindent = true
opt.background = "dark"
opt.backspace = "indent,eol,start"
opt.clipboard = vim.o.clipboard .. "unnamed,unnamedplus"
opt.cmdheight = 1
opt.completeopt = "menu,menuone,noselect,noinsert"
opt.cursorline = true
opt.expandtab = true
opt.inccommand = "split"
opt.ruler = true
opt.shiftwidth = 2
opt.shortmess = vim.o.shortmess .. "c"
opt.showtabline = 2
opt.signcolumn = "yes"
opt.softtabstop = 2
opt.tabstop = 2
opt.termguicolors = true
opt.updatetime = 50
opt.guicursor = ""
opt.number = true
opt.hidden = true
opt.undofile = true
opt.colorcolumn = "80,100,120"
opt.laststatus=3
opt.incsearch = true
vim.o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
-- opt.switchbuf = 'uselast'
-- opt.undordir = cache_dir .. "undodir/"
-- opt.noswapfile = true

vim.filetype.add {
  extension = {
    snap = 'json',
    png = 'image',
    jpg = 'image',
    jpeg = 'image',
    gif = 'image',
    es6 = 'javascript',
    mts = 'typescript',
    cts = 'typescript',
  },
  filename = {
    ['.eslintrc'] = 'json',
    ['.prettierrc'] = 'json',
    ['.babelrc'] = 'json',
    ['.stylelintrc'] = 'json',
  },
  pattern = {
    ['.*config/git/config'] = 'gitconfig',
    ['.env.*'] = 'dosini',
  },
}

-- vim.opt.foldenable = false
-- vim.opt.foldmethod = "manual"
vim.cmd [[ set foldlevel=0 ]]
vim.cmd [[ set foldmethod=manual ]]

vim.cmd "language en_US.utf-8"
vim.cmd [[ highlight clear SignColumn ]]

vim.cmd [[ set nowrap ]]
vim.cmd [[ set noshowmode ]]

