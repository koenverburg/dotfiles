on_attach = require("_apache.functions").on_attach
is_enabled = require("_apache.functions").is_enabled
local diagnosticSetup = require("experiments.diagnostic")

local servers = {
  vimls = {},
  dockerls = {},
  lua_ls = {
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
        hint = { enable = true },
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
  -- cssls = { cmd = { "vscode-css-language-server", "--stdio" } },
}

-- "ray-x/lsp_signature.nvim",
-- "nvim-lua/lsp_extensions.nvim",
-- { "simrat39/inlay-hints.nvim", lazy = true },
-- { "https://git.sr.ht/~whynothugo/lsp_lines.nvim", name = "lsp_lines.nvim" },

return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    enabled = is_enabled("lsp"),
    dependencies = {
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      -- vim.diagnostic.config({
      --   underline = true,
      --   update_in_insert = false,
      --   virtual_text = { spacing = 4, prefix = "●" },
      --   severity_sort = true,
      -- })
      diagnosticSetup.setup()
      local lspconfig = require("lspconfig")
      for name, opts in pairs(servers) do
        if type(opts) == "function" then
          opts()
        else
          local client = lspconfig[name]
          client.setup(vim.tbl_extend("force", {
            on_attach = on_attach,
            flags = { debounce_text_changes = 150 },
          }, opts))
        end
      end
    end,
  },
  {
    "L3MON4D3/LuaSnip",
    event = { "BufReadPre", "BufNewFile" },
    enabled = is_enabled("lsp-snippets"),
    dependencies = {
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local ls = require("luasnip")

      ls.config.set_config({
        history = false,
        updateevents = "TextChanged,TextChangedI",
      })

      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip.loaders.from_vscode").lazy_load({
        paths = { "./snippets/" },
      })
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    event = { "BufReadPre", "BufNewFile" },
    enabled = is_enabled("lsp"),
    dependencies = {
      "mason.nvim",
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
      "onsails/lspkind-nvim",
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        completion = {
          completeopt = "menu,menuone,noinsert",
        },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ["<S-CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
        confirm_opts = {
          behavior = cmp.ConfirmBehavior.Replace,
          select = false,
        },
        view = {
          entries = { name = "custom", selection_order = "near_cursor" },
        },
        formatting = {
          format = require("lspkind").cmp_format({
            mode = 'symbol_text'
          }),
        },
        experimental = {
          native_menu = false,
          ghost_text = {
            hl_group = "LspCodeLens",
          },
        },
      })
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    enabled = is_enabled("lsp") and is_enabled("lsp-formatting"),
    dependencies = { "mason.nvim" },
    opts = function()
      local nls = require("null-ls")
      local completion = nls.builtins.completion
      local formatting = nls.builtins.formatting
      return {
        on_attach = on_attach,
        sources = {
          completion.spell,

          formatting.gofmt,
          formatting.stylua, -- install with "cargo install stylua"

          -- brew install devopyio/yamlfmt/yamlfmt or go get -u github.com/devopyio/yamlfmt
          formatting.yamlfmt,
          formatting.prettier,
          formatting.npm_groovy_lint,
        },
      }
    end,
    config = function(_, opts)
      require("null-ls").setup(opts)
    end,
  },
  {
    "williamboman/mason.nvim",
    event = { "BufReadPre", "BufNewFile" },
    cmd = "Mason",
    enabled = is_enabled("lsp"),
    -- keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "gopls",
        "cssls",
        "lua_ls",
        "tsserver",
        "dockerls",
        "tailwindcss",
        "yamlls",
      },
    },
    config = function(_, opts)
      require("mason").setup(opts)
    end,
  },
  {
    "j-hui/fidget.nvim",
    enabled = is_enabled("lsp"),
    lazy = false,
    config = function()
      require("fidget").setup({
        text = {
          spinner = "dots_snake",
        },
      })
    end,
  },
  {
    "simrat39/symbols-outline.nvim",
    enabled = is_enabled("lsp"),
    config = function()
      require("symbols-outline").setup()
    end,
  },
}
