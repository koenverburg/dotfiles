local signs = {
  {name = "DiagnosticSignError", text = ""},
  {name = "DiagnosticSignWarn", text = ""},
  {name = "DiagnosticSignHint", text = ""},
  {name = "DiagnosticSignInfo", text = ""}
}

local function apply_signs()
  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, {texthl = sign.name, text = sign.text, numhl = ""})
  end
end

local config = {
  signs = {active = signs},
  underline = true,
  severity_sort = true,
  update_in_insert = false,

  virtual_text = false,
  -- virtual_text = { spacing = 4, prefix = "●" },
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = ""
  }
}

local M = {}
function M.setup()
  apply_signs()
  vim.diagnostic.config(config)
  -- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with({border = "rounded", width = 60})
  -- vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {border = "rounded", width = 60})
end

return M
