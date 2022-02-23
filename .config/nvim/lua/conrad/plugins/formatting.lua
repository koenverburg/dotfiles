local ok, ls = pcall(require, "null-ls")
if not ok then
  return
end

local spell = ls.builtins.completion
local formatting = ls.builtins.formatting
local diagnostics = ls.builtins.diagnostics

ls.setup {
  sources = {
    -- completion.spell,
    -- formatting.eslint,
    formatting.gofmt,
    formatting.stylua, -- install with cargo install stylua
    formatting.prettier,
    formatting.standardjs,
  },
}
