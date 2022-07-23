local ok, ls = pcall(require, "null-ls")
if not ok then
  return
end

local spell = ls.builtins.completion
local formatting = ls.builtins.formatting
local diagnostics = ls.builtins.diagnostics

local os = vim.loop.os_uname().sysname

local core_sources = {
  -- completion.spell,
  formatting.gofmt,
  formatting.stylua, -- install with "cargo install stylua"
  formatting.prettier,
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
  sources = TableConcat(sources, { formatting.eslint })
else
  sources = TableConcat(sources, { formatting.standardjs })
end

ls.setup {
  sources = sources,
}
