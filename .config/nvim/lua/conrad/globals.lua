vim.cmd "language en_US.utf-8"
vim.cmd [[ highlight clear SignColumn ]]

vim.cmd [[ set nowrap ]]
vim.cmd [[ set laststatus=3 ]]
vim.cmd [[ set noshowmode ]]
-- vim.cmd [[ set colorcolumn=80,90,120 ]]

-- vim.cmd [[ augroup illuminate_augroup ]]
-- vim.cmd [[ autocmd! ]]
-- vim.cmd [[ autocmd VimEnter * hi illuminatedWord cterm=underline gui=underline ]]
-- vim.cmd [[ augroup END ]]

-- vim.cmd [[ autocmd BufNewFile,BufRead *.js set ft=javascript ]]
-- vim.cmd [[ autocmd BufNewFile,BufRead *.jsx set ft=javascriptreact ]]
-- vim.cmd [[ autocmd BufNewFile,BufRead *.ts set ft=typescript ]]
-- vim.cmd [[ autocmd BufNewFile,BufRead *.tsx set ft=typescriptreact ]]

vim.g.mapleader = ","
vim.g.hidden = true
vim.g.nobackup = true
vim.g.undofile = true
vim.g.undordir = "~/.config/nvim/undodir"
-- vim.g.nowrap = true
vim.g.noswapfile = true

vim.wo.number = true
vim.wo.list = true
vim.wo.relativenumber = false

vim.opt.autoindent = true
vim.opt.autoindent = true
vim.opt.background = "dark"
vim.opt.backspace = "indent,eol,start"
vim.opt.clipboard = vim.o.clipboard .. "unnamed,unnamedplus"
vim.opt.cmdheight = 1
vim.opt.completeopt = "menu,menuone,noselect,noinsert"
vim.opt.cursorline = true
vim.opt.expandtab = true

-- vim.opt.foldenable = false
-- vim.opt.foldmethod = "manual"
vim.cmd [[ set foldlevel=0 ]]
vim.cmd [[ set foldmethod=manual ]]

vim.opt.inccommand = "split"
vim.opt.ruler = true
vim.opt.shiftwidth = 2
vim.opt.shortmess = vim.o.shortmess .. "c"
vim.opt.showtabline = 2
vim.opt.signcolumn = "yes"
vim.opt.softtabstop = 2
vim.opt.tabstop = 2
vim.opt.termguicolors = true

vim.g.DevIconsAppendArtifactFix = 1

-- Markdown
vim.g.vim_markdown_frontmatter = 1
vim.g.vim_markdown_folding_disabled = 1

-- json
vim.g.vim_json_syntax_conceal = 0

local function status_line()
  local file_name = "%t"
  local modified = " %-m"
  local right_align = "%="
  local line_no = "%10([%l/%L%)]"

  return string.format("%s%s%s%s", file_name, modified, right_align, line_no)
end

vim.opt.winbar = status_line()
