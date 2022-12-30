local utils = require "utils"
local lspconfig = require "lspconfig"
local lsp = {}

local servers = {
  vimls = {},
  dockerls = {},
  sumneko_lua = {
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
        hint = {
          enable = true,
        },
      },
    },
  },
  gopls = {
    settings = {
      gopls = {
        codelenses = {
          test = true,
          tidy = true,
          generate = true,
          references = true,
          upgrade_dependency = true,
        },
        hints = {
          assignVariableTypes = true,
          compositeLiteralFields = true,
          compositeLiteralTypes = true,
          constantValues = true,
          functionTypeParameters = true,
          parameterNames = true,
          rangeVariableTypes = true,
        },
        gofumpt = true,
      },
    },
  },
  tsserver = {
    root_dir = vim.loop.cwd,
    settings = {
      javascript = {
        inlayHints = {
          includeInlayEnumMemberValueHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
          includeInlayParameterNameHintsWhenArgumentMatchesName = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayVariableTypeHints = true,
        },
      },
      typescript = {
        inlayHints = {
          includeInlayEnumMemberValueHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
          includeInlayParameterNameHintsWhenArgumentMatchesName = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayVariableTypeHints = true,
        },
      },
    },
    filetypes = {
      "javascript",
      "javascriptreact",
      "javascript.jsx",

      "typescript",
      "typescriptreact",
      "typescript.tsx",
    },
  },
  html = { cmd = { "vscode-html-language-server", "--stdio" } },
  cssls = { cmd = { "vscode-css-language-server", "--stdio" } },
}

function lsp.init()
  require("mason").setup()
  require("mason-lspconfig").setup {
    ensure_installed = {
      "gopls",
      "cssls",
      "tsserver",
      "dockerls",
      "sumneko_lua",
      "tailwindcss",
    },
  }

  for name, opts in pairs(servers) do
    if type(opts) == "function" then
      opts()
    else
      local client = lspconfig[name]
      client.setup(vim.tbl_extend("force", {
        on_attach = utils.on_attach,
        flags = { debounce_text_changes = 150 },
      }, opts))
    end
  end

  -- require("lsp_lines").setup()
  require("fidget").setup {
    text = {
      spinner = "dots_snake",
    },
  }

  -- require("inlay-hints").setup {
  --   only_current_line = true,
  --
  --   eol = {
  --     right_align = true,
  --   },
  -- }
end

lsp.nullLs = function()
  -- local ls = require "null-ls"
  local ok, ls = pcall(require, "null-ls")

  if not ok then
    return
  end

  local completion = ls.builtins.completion
  local formatting = ls.builtins.formatting
  local d = ls.builtins.diagnostics

  local core_sources = {
    completion.spell,

    formatting.gofmt,
    formatting.stylua, -- install with "cargo install stylua"

    -- brew install devopyio/yamlfmt/yamlfmt or go get -u github.com/devopyio/yamlfmt
    formatting.yamlfmt,
    formatting.prettier,
  }

  local sources = core_sources
  local function TableConcat(t1, t2)
    for i = 1, #t2 do
      t1[#t1 + 1] = t2[i]
    end
    return t1
  end

  local hostname = vim.loop.os_gethostname()

  if string.find(hostname, "AMS") then
    sources = TableConcat(sources, {
      formatting.eslint,
    })
  else
    sources = TableConcat(sources, {
      formatting.standardts,
    })
  end

  ls.setup {
    debug = true,
    on_attach = utils.on_attach,
    sources = sources,
  }
end

lsp.callstack = function()
  require("litee.lib").setup()
  require("litee.calltree").setup()

  local litee = utils.loadable "litee.calltree.handlers"

  if not litee then return end
  local handlers = litee

  vim.lsp.handlers["callHierarchy/incomingCalls"] = vim.lsp.with(handlers.ch_lsp_handler "from", {})
  vim.lsp.handlers["callHierarchy/outgoingCalls"] = vim.lsp.with(handlers.ch_lsp_handler "to", {})
end

return lsp
