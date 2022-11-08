local utils = require('utils')
local ls = utils.loadable("null-ls")

-- local spell = ls.builtins.completion
local formatting = ls.builtins.formatting
-- local diagnostics = ls.builtins.diagnostics

local core_sources = {
  -- completion.spell,
  formatting.gofmt,
  formatting.stylua, -- install with "cargo install stylua"
  formatting.prettier,
  -- diagnostics.prettier
}

local function TableConcat(t1, t2)
  for i = 1, #t2 do
    t1[#t1 + 1] = t2[i]
  end
  return t1
end

local hostname = vim.loop.os_gethostname()
local sources = core_sources

if string.find(hostname, 'AMS') then
  sources = TableConcat(sources, {
    -- diagnostics.eslint,
    formatting.eslint
  })
else
  sources = TableConcat(sources, {
    -- diagnostics.standardjs,
    formatting.standardjs
  })
end

ls.setup {
  sources = {},
}
