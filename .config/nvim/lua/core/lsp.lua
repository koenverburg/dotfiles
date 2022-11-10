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
          globals = { 'vim' }
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
      spinner = "dots_snake"
    }
  }

  require("inlay-hints").setup({
    only_current_line = true,

    eol = {
      right_align = true,
    }
  })
end

lsp.nullLs = function()
  local ls = require('null-ls')
  local utils = require('utils')
  local completion = ls.builtins.completion
  local formatting = ls.builtins.formatting
  -- local diagnostics = ls.builtins.diagnostics

  local core_sources = {
    completion.spell,

    formatting.gofmt,
    formatting.stylua, -- install with "cargo install stylua"
    formatting.eslint,

    formatting.prettier,
  }
  -- local sources = core_sources
  -- local function TableConcat(t1, t2)
  --   for i = 1, #t2 do
  --     t1[#t1 + 1] = t2[i]
  --   end
  --   return t1
  -- end
  --
  -- local hostname = vim.loop.os_gethostname()
  --
  -- if string.find(hostname, 'AMS') then
  --   sources = TableConcat(sources, {
  --     -- diagnostics.eslint,
  --     formatting.eslint
  --   })
  -- else
  --   sources = TableConcat(sources, {
  --     -- diagnostics.standardjs,
  --     formatting.standardjs
  --   })
  -- end

  ls.setup({
    debug = true,
    on_attach = utils.on_attach,
    sources = {
      -- ls.builtins.completion.spell,
      -- ls.builtins.formatting.stylua,

      -- ls.builtins.formatting.eslint,
      -- ls.builtins.formatting.prettier,
      -- ls.builtins.diagnostics.eslint,
    },
  })
end

return lsp
