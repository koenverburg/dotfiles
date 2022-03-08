local M = {}

-- local defaults = tableToString {
--   vert = ":▕", -- alternatives │
--   fold = " ",
--   eob = "~", -- suppress ~ at EndOfBuffer
--   diff = "─", -- alternatives: ⣿ ░
--   msgsep = "‾",
--   foldopen = "▾",
--   foldsep = "│",
--   foldclose = "▸",
-- }

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
  conceal = "┊",
}

-- vim.opt.listchars = {
local quite_list = {
  eol = " ",
  tab = "  ",
  trail = " ",
  space = " ",
  nbsp = "☠",
  extends = "#",
  precedes = "…",
  conceal = "┊",
}

local function tableToString(value)
  if value == nil then
    print "table is empty"
    return
  end
  if not type(value) == "table" then
    print(string.format("Please add a table instead of %s", type(value)))
    return
  end

  list = {}
  for k, v in pairs(value) do
    char_format = string.format("%s:%s", k, v)
    -- print(char_format)
    table.insert(list, char_format)
  end

  r = table.concat(list, ",")
  return r
end

function M.setup(options)
  options = options or {}

  M.options = vim.tbl_deep_extend("force", {
    enable = true,
    defaults = {
      eol = "↲",
      tab = "» ",
      trail = "·",
      space = "·",
      nbsp = "☠",
      -- nbsp = '␣',
      extends = "#",
      precedes = "…",
      conceal = "┊",
    },
  }, options)

  if not M.options.enabled then
    print('not enabled')
    return
  end
  print('enabled')

  vim.o.listchars = tableToString(default_list)
end

return M
