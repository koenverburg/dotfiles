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
  yamlls = {
    settings = {
      yaml = {
        schemas = { kubernetes = "globPattern" },
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

local lsp_map = function(mode, key, action)
  local command = string.format("<cmd>lua %s()<cr>", action)
  vim.api.nvim_buf_set_keymap(0, mode, key, command, { noremap = true, silent = true })
end

local on_attach = function(client, bufnr)
  -- require("experiments.show-references").on_attach(client, bufnr)

  if client.name == "tsserver" or client.name == "sumneko_lua" or client.name == "gopls" then
    client.server_capabilities.document_formatting = false
  end

  if client.name == "tsserver" or client.name == "sumneko_lua" or client.name == "gopls" then
    require("inlay-hints").on_attach(client, bufnr)
  end

  if client.server_capabilities.documentSymbolProvider then
    require("nvim-navic").attach(client, bufnr)
  end

  utils.normal("<leader>lf", [[ <cmd>lua vim.lsp.buf.format({async=true})<cr> ]])
  -- utils.normal("gp", "<cmd>lua require('peek').Peek('definition')<cr>")

  lsp_map("n", "K", "vim.lsp.buf.hover")
  lsp_map("n", "gD", "vim.lsp.buf.declaration")
  lsp_map("n", "gd", "vim.lsp.buf.definition")
  lsp_map("n", "<c-]>", "vim.lsp.buf.definition")
  lsp_map("n", "gi", "vim.lsp.buf.implementation")
  lsp_map("n", "goc", "vim.lsp.buf.outgoing_calls")

  -- lsp saga
  lsp_map("n", "K", "require('lspsaga.hover').render_hover_doc")
  lsp_map("n", "gr", "require('lspsaga.rename').rename")

  lsp_map("n", "<leader>ca", "require('lspsaga.codeaction').code_action")
  lsp_map("i", "<leader>ca", "require('lspsaga.codeaction').code_action")

  lsp_map("n", "gx", "Lspsaga code_action<cr>")
  lsp_map("x", "gx", ":<c-u>Lspsaga range_code_action<cr>")

  -- Moved to telescope for these
  -- lsp_map('n', '<c-r>', 'vim.lsp.buf.references')
  -- lsp_map('n', 'gds', 'vim.lsp.buf.document_symbol')
  -- lsp_map('n', 'gW', 'vim.lsp.buf.workspace_symbol')

  lsp_map("n", "<leader>sd", "require('lspsaga.diagnostic').show_line_diagnostics")
  lsp_map("n", "[e", "require('lspsaga.diagnostic').lsp_jump_diagnostic_prev")
  lsp_map("n", "]e", "require('lspsaga.diagnostic').lsp_jump_diagnostic_next")
end

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
      "yamlls",
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

lsp.lines = function ()
  require("lsp_lines").setup()
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
    on_attach = on_attach,
    sources = sources,
  }
end

lsp.callstack = function()
  require("litee.lib").setup()
  require("litee.calltree").setup()

  local litee = utils.loadable "litee.calltree.handlers"

  if not litee then
    return
  end
  local handlers = litee

  vim.lsp.handlers["callHierarchy/incomingCalls"] = vim.lsp.with(handlers.ch_lsp_handler "from", {})
  vim.lsp.handlers["callHierarchy/outgoingCalls"] = vim.lsp.with(handlers.ch_lsp_handler "to", {})
end

return lsp
