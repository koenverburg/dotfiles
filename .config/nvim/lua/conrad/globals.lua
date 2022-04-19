vim.o.ruler = true
vim.o.background = "dark"

require('ayu').setup({
  mirage = false, -- Set to `true` to use `mirage` variant instead of `dark` for dark background.
})

vim.cmd [[ colorscheme ayu-dark ]]

vim.cmd [[ highlight NonText guibg=none ]]
vim.cmd [[ highlight Normal guibg=none ]]

vim.o.signcolumn = "number"

vim.g.mapleader = ","
vim.b.mapleader = ","

vim.g.hidden = true
vim.g.nobackup = true
vim.b.noswapfile = true
vim.g.undofile = true
vim.g.undordir = "~/.config/nvim/undodir"

vim.wo.number = true
vim.wo.relativenumber = false
vim.wo.wrap = true
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

vim.cmd "language en_US.utf-8"

vim.o.termguicolors = true
vim.o.completeopt = "menu,menuone,noselect,noinsert"
vim.o.backspace = "indent,eol,start"

vim.o.inccommand = "split"
vim.o.shortmess = vim.o.shortmess .. "c"
vim.o.cmdheight = 1

vim.o.clipboard = vim.o.clipboard .. "unnamed,unnamedplus"
vim.o.termguicolors = true
vim.o.showtabline = 2

vim.cmd [[ set laststatus=3 ]]
-- vim.cmd [[ hightlight WinSeparator guibg=none ]]

vim.opt.foldlevel = 99
vim.opt.foldmethod = "manual"
vim.opt.foldcolumn = "1"
-- folding
-- vim.cmd [[ set foldlevel=99 ]]
-- vim.cmd [[ set foldmethod=manual ]]

vim.cmd [[ highlight clear SignColumn ]]
vim.cmd [[ set noshowmode ]]

vim.cmd [[ set colorcolumn=120 ]]

vim.cmd [[ augroup illuminate_augroup ]]
vim.cmd [[ autocmd! ]]
vim.cmd [[ autocmd VimEnter * hi illuminatedWord cterm=underline gui=underline ]]
vim.cmd [[ augroup END ]]

vim.g.DevIconsAppendArtifactFix = 1

-- Markdown
vim.g.vim_markdown_frontmatter = 1
vim.g.vim_markdown_folding_disabled = 1

-- json
vim.g.vim_json_syntax_conceal = 0
