local core = require("_apache.core")
local on_attach = require("_apache.functions").on_attach
local is_enabled = require("_apache.functions").is_enabled
local diagnosticSetup = require("experiments.diagnostic")
-- local cody = require("experiments.cody")

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
        hints = {
          constantValues = true,
          parameterNames = true,
          rangeVariableTypes = true,
          assignVariableTypes = true,
          compositeLiteralTypes = true,
          compositeLiteralFields = true,
          functionTypeParameters = true,
        },
      },
    },
  },
  tsserver = {
    root_dir = vim.loop.cwd,
    disable_formatting = true,
    settings = {
      javascript = {
        inlayHints = {
          includeInlayParameterNameHints = 'all',
          includeInlayVariableTypeHints = true,
          includeInlayEnumMemberValueHints = true,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayVariableTypeHintsWhenTypeMatchesName = false,
          includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        },
      },
      typescript = {
        inlayHints = {
          includeInlayParameterNameHints = 'all',
          includeInlayParameterNameHintsWhenArgumentMatchesName = true,

          includeInlayVariableTypeHints = true,
          includeInlayVariableTypeHintsWhenTypeMatchesName = false,

          includeInlayFunctionParameterTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,

          includeInlayEnumMemberValueHints = true,

          includeInlayPropertyDeclarationTypeHints = true,
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
  -- llmsp = {
  --   settings = {
  --     llmsp = {
  --       sourcegraph = {
  --         autoComplete = "always",
  --         accessToken = cody.get_token(),
  --         url = "https://sourcegraph.sourcegraph.com",
  --       },
  --     },
  --   },
  -- },
}

-- "nvim-lua/lsp_extensions.nvim",
-- { "https://git.sr.ht/~whynothugo/lsp_lines.nvim", name = "lsp_lines.nvim" },

return {
  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    lazy = false,
    enabled = is_enabled("lsp"),
    ft = { "go", "gomod" },
    event = { "CmdlineEnter" },
    build = ':lua require("go.install").update_all_sync()',
    config = function()
      require("go").setup({
        hint = true,
      })
    end,
  },
  {
    "VidocqH/lsp-lens.nvim",
    enabled = is_enabled("lsp"),
    event = "BufRead",
    opts = {
      include_declaration = true, -- Reference include declaration
      sections = { -- Enable / Disable specific request
        definition = false,
        references = true,
        implementation = false,
      },
    },
    keys = {
      {
        -- LspLensToggle
        "<leader>uL",
        "<cmd>LspLensToggle<CR>",
        desc = "LSP Len Toggle",
      },
    },
  },
  {
    "koenverburg/lsp-inlayhints.nvim",
    ft = { "javascript", "javascriptreact", "json", "jsonc", "typescript", "typescriptreact" },
    event = "LspAttach",
    branch = "anticonceal",
    enabled = is_enabled("lsp"),
    opts = {
      inlay_hints = {
        parameter_hints = {
          show = true,
          prefix = "",
          separator = ", ",
          remove_colon_end = true,
          remove_colon_start = true,
        },
        type_hints = {
          show = true,
          prefix = "",
          separator = ", ",
          remove_colon_end = true,
          remove_colon_start = true,
        },
        only_current_line = false,
        labels_separator = " ",
        max_len_align = false,
        max_len_align_padding = 1,
        highlight = "LspInlayHint",
        priority = 0,
      },
      enabled_at_startup = true,
      debug_mode = false,
    },
    init = function(_, options)
      vim.api.nvim_create_augroup("LspAttach_inlayhints", {})
      vim.api.nvim_create_autocmd("LspAttach", {
        group = "LspAttach_inlayhints",
        callback = function(args)
          if not (args.data and args.data.client_id) then
            return
          end

          local bufnr = args.buf
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          require("lsp-inlayhints").on_attach(client, bufnr)
        end,
      })

      require("lsp-inlayhints").setup(options)

      vim.api.nvim_set_keymap(
        "n",
        "<leader>uI",
        "<cmd>lua require('lsp-inlayhints').toggle()<CR>",
        { noremap = true, silent = true }
      )
    end,
  },
  {
    "ray-x/lsp_signature.nvim",
    event = { "BufReadPre", "BufNewFile" },
    enabled = is_enabled("lsp"),
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    enabled = is_enabled("lsp"),
    dependencies = {
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "gopls",
          "cssls",
          "yamlls",
          "tsserver",
          "dockerls",
          "tailwindcss",
          -- "sumneko_lua",
        },
      })

      diagnosticSetup.setup()
      local lspconfig = require("lspconfig")
      -- cody.register_llmsp_config(lspconfig)
      -- cody.set_explain()

      for name, opts in pairs(servers) do
        if type(opts) == "function" then
          opts()
        else
          local client = lspconfig[name]
          client.setup(vim.tbl_extend("force", {
            inlay_hints = { enabled = true },
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
          { name = "nvim_lua" },
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "path" },
          { name = "buffer", keyword_length = 5 },
        }),
        confirm_opts = {
          behavior = cmp.ConfirmBehavior.Replace,
          select = false,
        },
        view = {
          entries = { name = "custom", selection_order = "near_cursor" },
        },
        window = {
          -- completion = cmp.config.window.bordered({
          --   border = "rounded",
          -- }),
        },
        sorting = {
          -- TODO: Would be cool to add stuff like "See variable names before method names" in rust, or something like that.
          comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,

            -- copied from cmp-under, but I don't think I need the plugin for this.
            -- I might add some more of my own.
            function(entry1, entry2)
              local _, entry1_under = entry1.completion_item.label:find("^_+")
              local _, entry2_under = entry2.completion_item.label:find("^_+")
              entry1_under = entry1_under or 0
              entry2_under = entry2_under or 0
              if entry1_under > entry2_under then
                return false
              elseif entry1_under < entry2_under then
                return true
              end
            end,

            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
          },
        },
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = function(entry, vim_item)
            vim_item.kind = (core.icons[vim_item.kind] or "?") .. " " .. vim_item.kind
            vim_item.menu = entry.source.name

            vim_item.abbr = vim_item.abbr:match("[^(]+")

            return vim_item
          end,
        },
        experimental = {
          native_menu = false,
          ghost_text = false,
          --[[ ghost_text = {
            hl_group = "LspCodeLens",
          }, ]]
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
