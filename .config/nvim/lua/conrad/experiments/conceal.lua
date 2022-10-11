local M = {}

function conceal(operator, keyword, char)
  vim.cmd(string.format("syntax keyword {0} {1} conceal cchar={2}", operator, keyword,char))
end

conceal("luaConstant", "local", 'l')

return M
