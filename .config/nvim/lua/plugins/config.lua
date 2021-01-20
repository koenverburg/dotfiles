vim.cmd [[ augroup illuminate_augroup ]]
vim.cmd [[ autocmd! ]]
vim.cmd [[ autocmd VimEnter * hi illuminatedWord cterm=underline gui=underline ]]
vim.cmd [[ augroup END ]]

vim.g.DevIconsAppendArtifactFix = 1

local lualine = require('lualine')

lualine.theme = 'nord'
lualine.sections = {
  lualine_a = { 'mode' },
  lualine_b = { 'branch' },
  lualine_c = { 'filename' },
  lualine_x = { 'encoding', 'filetype' }, -- 'encoding', 'fileformat', 'filetype' 
  -- lualine_y = {},
  lualine_z = { 'location'  },
}

lualine.status()
