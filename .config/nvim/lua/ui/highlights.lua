local highlight = {}

highlight.hop = function()
  local c = require("colorbuddy.color").colors
  local s = require("colorbuddy.style").styles
  local Group = require("colorbuddy.group").Group

  Group.new("HopNextKey", c.pink, nil, s.bold)
  Group.new("HopNextKey1", c.cyan:saturate(), nil, s.bold)
  Group.new("HopNextKey2", c.cyan:dark(), nil)
end

highlight.setup = function()
  require("murmur").setup {}
  vim.api.nvim_set_hl(0, "murmur_cursor_rgb", { fg = "#0a100d", bg = "#ffcc00" })
end

highlight.fix = function()
  vim.cmd [[ hi TabLine     ctermfg=none ctermbg=none gui=none cterm=none term=none ]]
  vim.cmd [[ hi TabLineSel  ctermfg=none ctermbg=none gui=none cterm=none term=none ]]
  vim.cmd [[ hi TabLineFill ctermfg=none ctermbg=none gui=none cterm=none term=none ]]
end

return highlight
