local highlight = {}

highlight.setup = function()
  require('murmur').setup({})
end

highlight.fix = function()
  vim.cmd [[ hi TabLine     ctermfg=none ctermbg=none gui=none cterm=none term=none ]]
  vim.cmd [[ hi TabLineSel  ctermfg=none ctermbg=none gui=none cterm=none term=none ]]
  vim.cmd [[ hi TabLineFill ctermfg=none ctermbg=none gui=none cterm=none term=none ]]
end

return highlight
