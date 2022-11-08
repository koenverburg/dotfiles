local M = {}

local conceal = function(operator, keyword, char)
  local cmd = string.format("syntax match %s %s conceal cchar=%s", operator, keyword, char)

  -- print(cmd)

  vim.cmd(cmd)
end

-- conceal("Normal", "function", 'f')
-- conceal("Keyword", "return", '>')
-- conceal("Keyword", "local", 'l')

M.typescript = function ()
  -- conceal("Normal", "function", 'f')
  -- conceal("Keyword", "return", '>')
  --
  -- conceal("Keyword", "const", 'c')
  -- conceal("Keyword", "let", 'l')
  --
  -- conceal("Keyword", "import", 'i')
  -- conceal("Keyword", "from", 'f')
  --
  -- conceal("Keyword", "export", 'e')
  --
  -- conceal("Keyword", "yield", 'y')

  -- conceal("Keyword", "&&", '&')
  -- conceal("Keyword", "||", '|')
end

return M
