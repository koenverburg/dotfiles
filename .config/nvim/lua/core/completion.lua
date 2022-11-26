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
    virtual_text = false,
  })
end

function config.luasnip()
  local ls = require('luasnip')

  ls.config.set_config({
    history = false,
    updateevents = 'TextChanged,TextChangedI',
  })

  require('luasnip.loaders.from_vscode').lazy_load()
  require('luasnip.loaders.from_vscode').lazy_load({
    paths = { './snippets/' },
  })
end

function config.cmp()
  local cmp = require "cmp"
  local lspkind = require "lspkind"
  local lspconfig = require "lspconfig"
  local lsp_defaults = lspconfig.util.default_config

  lsp_defaults.capabilities = vim.tbl_deep_extend(
    'force',
    lsp_defaults.capabilities,
    require('cmp_nvim_lsp').default_capabilities()
  )

  cmp.setup {
    snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end,
    },
    mapping = {
      ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
      ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
      ["<C-d>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.close(),
      ["<C-k>"] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      },
      ["<Tab>"] = cmp.mapping(
        cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        },
        { "i", "s" }
      ),
    },
    confirm_opts = {
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    },
    experimental = {
      native_menu = false,
      ghost_text = true,
    },
    formatting = {
      format = lspkind.cmp_format(),
    },
    view = {
      entries = { name = "custom", selection_order = "near_cursor" },
    },
    sources = {
      { name = "nvim_lsp" },
      { name = "luasnip",  keyword_length = 1  },
      { name = "buffer",   keyword_length = 3 },
      { name = "path",     keyword_length = 4 },
    },
  }
end

return config
