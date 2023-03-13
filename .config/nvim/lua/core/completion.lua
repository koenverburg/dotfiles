local config = {}

function config.diagnostic()
  vim.lsp.handlers["textDocument/publishDiagnostics"] =
  vim.lsp.with(vim.lsp.handlers["textDocument/publishDiagnostics"], {
    signs = {
      severity_limit = "Error",
    },
    underline = {
      severity_limit = "Warning",
    },
  })

  vim.diagnostic.config({
    virtual_text = true,
  })
end

return config
