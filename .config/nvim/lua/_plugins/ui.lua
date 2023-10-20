local funcs = require("logic.functions")
local is_enabled = funcs.is_enabled
local icons = require("core.config").signs

return {
  {
    "anuvyklack/pretty-fold.nvim",
    enabled = is_enabled("pretty-fold"),
    lazy = false,
    config = function()
      require("pretty-fold").setup({
        -- fill_char = '-',
      })
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    enabled = is_enabled("indent-blankline"),
    main = "ibl",
    lazy = false,
    opts = {
      scope = {
        enabled = false
      },
    },
    config = function(_, opts)
      require("ibl").setup(opts)
    end,
  },
  {
    "kyazdani42/nvim-web-devicons",
    enabled = is_enabled("icons"),
    lazy = false,
    config = function()
      require("nvim-web-devicons").setup()
    end,
  },
  {
    "folke/noice.nvim",
    enabled = is_enabled("noice"),
    lazy = false,
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    opts = {
      lsp = {
        override = {
          ["vim.lsp.handlers['textDocument/hover']"] = false,
          ["vim.lsp.handlers['textDocument/signatureHelp']"] = false,
        },
        hover = {
          enabled = false,
        },
        signature = {
          enabled = false,
        },
      },
      --   hover = {
      --     enabled = true,
      --     view = nil, -- when nil, use defaults from documentation
      --     ---@type NoiceViewOptions
      --     opts = {}, -- merged with defaults from documentation
      --     border = {
      --       style = "rounded",
      --     },
      --   },
      --   signature = {
      --     enabled = true,
      --     auto_open = {
      --       enabled = true,
      --       trigger = true, -- Automatically show signature help when typing a trigger character from the LSP
      --       luasnip = true, -- Will open signature help when jumping to Luasnip insert nodes
      --       throttle = 50, -- Debounce lsp signature help request by 50ms
      --     },
      --     view = nil, -- when nil, use defaults from documentation
      --     ---@type NoiceViewOptions
      --     opts = {}, -- merged with defaults from documentation
      --   },
      --   documentation = {
      --     view = "hover",
      --     ---@type NoiceViewOptions
      --     opts = {
      --       lang = "markdown",
      --       replace = true,
      --       render = "plain",
      --       format = { "{message}" },
      --       win_options = { concealcursor = "n", conceallevel = 3 },
      --     },
      --   },
      -- },
      -- popupmenu = {
      --   enabled = true, -- enables the Noice popupmenu UI
      --   ---@type 'nui'|'cmp'
      --   backend = "nui", -- backend to use to show regular cmdline completions
      --   ---@type NoicePopupmenuItemKind|false
      --   -- Icons for completion item kinds (see defaults at noice.config.icons.kinds)
      --   kind_icons = {}, -- set to `false` to disable icons
      -- },
      -- presets = {
      --   inc_rename = false, -- enables an input dialog for inc-rename.nvim
      --   bottom_search = false, -- use a classic bottom cmdline for search
      --   lsp_doc_border = false, -- add a border to hover docs and signature help
      --   command_palette = false, -- position the cmdline and popupmenu together
      --   long_message_to_split = false, -- long messages will be sent to a split
      -- },
      cmdline = {
        enabled = true,         -- enables the Noice cmdline UI
        view = "cmdline_popup", -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
        format = {
          search_up = { kind = "search", pattern = "^%?", icon = "", lang = "regex" },
          search_down = { kind = "search", pattern = "^/", icon = "", lang = "regex" },
          cmdline = { pattern = "^:", icon = "", lang = "vim" },
          filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
          lua = { pattern = "^:%s*lua%s+", icon = "", lang = "lua" },
          help = { pattern = "^:%s*he?l?p?%s+", icon = "" },
          -- input = {}, -- Used by input()
        },
      },
    },
    config = function(_, opts)
      require("noice").setup(opts)
    end,
  },
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    enabled = is_enabled("dashboard"),
    opts = function()
      local dashboard = require("alpha.themes.dashboard")
      -- local query = require('possession.query')
      -- Memento Mori
      -- Memento Vivere
      -- Now its your turn
      local logo = [[


Sigma

86400

discipline

Memento Mori

Memento Vivere

It's Your Turn

Life Is Yours To Create

      ]]

      dashboard.section.header.val = vim.split(logo, "\n")
      dashboard.section.buttons.val = {
        dashboard.button(
          "s",
          " " .. " List Sessions",
          [[<cmd>lua require('telescope').extensions.possession.list()<cr>]]
        ),
        dashboard.button("s", " " .. " Show Session", [[<cmd>PossessionShow<cr>]]),
        -- dashboard.button("s", " " .. " Create Session",
        --   [[<cmd>lua require('_apache.functions').createSession()<cr>]]
        -- ),
        dashboard.button("q", " " .. " Quit", ":qa<CR>"),
      }
      return dashboard
    end,
    config = function(_, dashboard)
      -- close Lazy and re-open when the dashboard is ready
      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          pattern = "AlphaReady",
          callback = function()
            require("lazy").show()
          end,
        })
      end
      require("alpha").setup(dashboard.opts)
      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyVimStarted",
        callback = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          dashboard.section.footer.val = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
          pcall(vim.cmd.AlphaRedraw)
        end,
      })
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    cmd = "Neotree",
    enabled = is_enabled("explorer"),
    keys = {
      {
        "<C-b>",
        function()
          require("neo-tree.command").execute({
            toggle = true,
            dir = vim.loop.cwd(),
          })
        end,
        desc = "Explorer NeoTree (cwd)",
      },
      {
        "<space>b",
        function()
          require("neo-tree.command").execute({
            toggle = true,
            dir = vim.loop.cwd(),
          })
        end,
        desc = "Explorer NeoTree (cwd)",
      },
    },
    deactivate = function()
      vim.cmd([[Neotree close]])
    end,
    init = function()
      vim.g.neo_tree_remove_legacy_commands = 1
      if vim.fn.argc() == 1 then
        local stat = vim.loop.fs_stat(vim.fn.argv(0))
        if stat and stat.type == "directory" then
          require("neo-tree")
        end
      end
    end,
    opts = {
      filesystem = {
        bind_to_cwd = false,
        follow_current_file = true,
      },
      window = {
        position = "right",
        mappings = {
          ["<space>"] = "none",
        },
      },
      default_component_configs = {
        indent = {
          with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
          expander_collapsed = "",
          expander_expanded = "",
          expander_highlight = "NeoTreeExpander",
        },
      },
    },
    config = function(_, opts)
      require("neo-tree").setup(opts)
    end,
  },
  {
    "smithbm2316/centerpad.nvim",
    enabled = is_enabled("centerpad"),
    lazy = false,
    keys = {
      {
        "<space>c",
        function()
          require("centerpad").toggle()
        end,
        desc = "Centerpad",
      },
    },
  },
}
