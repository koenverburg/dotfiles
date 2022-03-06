local function add(value, str, sep)
  sep = sep or ','
  str = str or ''

  value = type(value) == 'table' and table.concat(value, sep) or value

  return str ~= '' and table.concat({ value, str }, sep) or value
end

vim.o.fillchars = add {
  'vert:▕', -- alternatives │
  'fold: ',
  'eob:~', -- suppress ~ at EndOfBuffer
  'diff:─', -- alternatives: ⣿ ░
  'msgsep:‾',
  'foldopen:▾',
  'foldsep:│',
  'foldclose:▸'
}

-- vim.opt.listchars = {
local default_list = {
  eol = "↲",
  tab = "» ",
  trail = "·",
  space = "·",
  nbsp = "☠",
  -- nbsp = '␣',
  extends = "#",
  precedes = "…",
  conceal = "┊"
}

-- vim.opt.listchars = {
local quite_list = {
  eol = "  ",
  tab = "  ",
  trail = "  ",
  space = "  ",
  nbsp = "☠",
  extends = "#",
  precedes = "…",
  conceal = "┊"
}

-- vim.o.listchars = add {
--   'eol: ',
--   'tab:│ ',
--   'extends:›', -- Alternatives: … »
--   'precedes:‹', -- Alternatives: … «
--   'trail:•' -- BULLET (U+2022, UTF-8: E2 80 A2)
-- }

local M = {}
function M.setListchars(list)
  vim.o.listchars = add(list)
end

-- M.setListchars({
--   'eol: ',
--   'tab:  ',
--   'trail: ',
--   'space: ',
--   'nbsp: ',
--   'extends: ',
--   'precedes: ',
--   'conceal: '
-- })

M.setListchars({
  'eol:↲',
  'tab:» ',
  'trail:•',
  'space:·',
  'nbsp:☠',
  -- 'nbsp = '␣'
  'extends:#',
  'precedes:…',
  'conceal:┊'
})
