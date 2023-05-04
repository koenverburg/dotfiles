local is_enabled = require("_apache.functions").is_enabled

return {
  {
    "stevearc/dressing.nvim",
    enabled = is_enabled("dressing"),
    lazy = false,
    -- init = function()
    --   ---@diagnostic disable-next-line: duplicate-set-field
    --   vim.ui.select = function(...)
    --     require("lazy").load({ plugins = { "dressing.nvim" } })
    --     return vim.ui.select(...)
    --   end
    --   ---@diagnostic disable-next-line: duplicate-set-field
    --   vim.ui.input = function(...)
    --     -- require("lazy").load({ plugins = { "dressing.nvim" } })
    --     return vim.ui.input(...)
    --   end
    -- end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    enabled = is_enabled("indent-blankline"),
    lazy = false,
    opts = {
      show_current_context = true,
      show_current_context_start = false,
    },
    config = function(_, opts)
      require("indent_blankline").setup(opts)
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
    "tjdevries/express_line.nvim",
    dependencies = {
      "nvim-lua/popup.nvim",
      "nvim-lua/plenary.nvim",
    },
    enabled = is_enabled("expressline"),
    lazy = false,
    config = function()

      local helper        = require("el.helper")
      local extensions    = require("el.extensions")
      local builtin       = require("el.builtin")
      local sections      = require("el.sections")
      local stl           = require('experiments.statusline')
      local stl_providers = stl.providers

      local render_async = function(id, autocmd, element)
        return helper.async_buf_setter(
          id,
          autocmd,
          element,
          5000
        )
      end

      local generator = function(window, _) -- window, bufnr
        local segments = {}
        table.insert(segments, stl.builtins.space)
        table.insert(segments, extensions.mode)

        table.insert(segments, stl.builtins.space)
        table.insert(segments, render_async(window.win_id, 'el_git_branch', stl_providers.git_branch))

        table.insert(segments, stl.builtins.space)
        table.insert(segments, render_async(window.win_id, 'el_git_stat', stl_providers.git_changes))

        table.insert(segments, stl.builtins.space)
        table.insert(segments, sections.split)

        table.insert(segments, stl.builtins.space)
        table.insert(segments, stl_providers.file_icon)
        table.insert(segments, stl.builtins.space)
        table.insert(segments, stl_providers.filename)
        table.insert(segments, builtin.modified)
        table.insert(segments, stl.builtins.space)

        table.insert(segments, sections.split)
        table.insert(segments, stl_providers.diagnostic)
        table.insert(segments, stl_providers.lsp_enabled and stl_providers.lsp() or stl_providers.filetype())
        table.insert(segments, sections.collapse_builtin(builtin.help_list, builtin.readonly_list))

        table.insert(segments, stl.builtins.space)
        return segments
      end

      local ignore  = { "help", "packer", "spectre_panel", "TelescopePrompt" }
      local disable = { "neogitstatus", "netrw", "lir", "lazy", "alpha", "Outline", "NeogitStatus", "NeogitCommitMessage" }

      require("el").setup({
        generator = generator,
        regenerate_autocmds = {
          "WinEnter",
          "WinLeave",
          "DiagnosticChanged",
          "ModeChanged",
          "BufEnter",
          "BufWritePost",
        },
      })
    end,
  },
  {
    "gen740/SmoothCursor.nvim",
    lazy = false,
    enabled = is_enabled("smoothcursor"),
    opts = {
      autostart = true,
      cursor = "",          -- cursor shape (need nerd font)
      texthl = "SmoothCursor", -- highlight group, default is { bg = nil, fg = "#FFD400" }
      linehl = nil,            -- highlight sub-cursor line like 'cursorline', "CursorLine" recommended
      type = "default",        -- define cursor movement calculate function, "default" or "exp" (exponential).
      fancy = {
        enable = true,         -- enable fancy mode
        head = { cursor = "", texthl = "SmoothCursor", linehl = nil },
        body = {
          { cursor = "", texthl = "SmoothCursorRed" },
          { cursor = "", texthl = "SmoothCursorOrange" },
          { cursor = "●", texthl = "SmoothCursorYellow" },
          { cursor = "●", texthl = "SmoothCursorGreen" },
          { cursor = "•", texthl = "SmoothCursorAqua" },
          { cursor = ".",   texthl = "SmoothCursorBlue" },
          { cursor = ".",   texthl = "SmoothCursorPurple" },
        },
        tail = { cursor = nil, texthl = "SmoothCursor" },
      },
      flyin_effect = nil,        -- "bottom" or "top"
      speed = 25,                -- max is 100 to stick to your current position
      intervals = 35,            -- tick interval
      priority = 10,             -- set marker priority
      timeout = 3000,            -- timout for animation
      threshold = 3,             -- animate if threshold lines jump
      disable_float_win = false, -- disable on float window
      enabled_filetypes = nil,   -- example: { "lua", "vim" }
      disabled_filetypes = nil,  -- this option will be skipped if enabled_filetypes is set. example: { "TelescopePrompt", "NvimTree" }
    },
    config = function(_, opts)
      require("smoothcursor").setup(opts)
    end,
  },
  {
    "m4xshen/smartcolumn.nvim",
    lazy = false,
    enabled = is_enabled("smartcolumn"),
    opts = {
      colorcolumn = 80,
      limit_to_line = false,
      limit_to_window = false,
      custom_colorcolumn = {},
      disabled_filetypes = { "help", "text", "markdown" },
    },
    config = function(_, opts)
      require("smartcolumn").setup(opts)
    end,
  },
  {
    "rcarriga/nvim-notify",
    enabled = is_enabled("notify"),
    lazy = false,
    keys = {
      {
        "<leader>un",
        function()
          require("notify").dismiss({ silent = true, pending = true })
        end,
        desc = "Delete all Notifications",
      },
    },
    opts = {
      timeout = 3000,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
    },
    config = function(_, opts)
      require("notify").setup(opts)
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
          enabled = false
        },
        signature = {
          enabled = false
        }
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
      -- Memento Mori
      -- Memento Vivere
      -- Now its your turn
      local logo = [[


          __    __  ______  __    __  ______  __   __  ______  ______       __    __  ______  ______  __
         /\ "-./  \/\  ___\/\ "-./  \/\  ___\/\ "-.\ \/\__  _\/\  __ \     /\ "-./  \/\  __ \/\  == \/\ \
         \ \ \-./\ \ \  __\\ \ \-./\ \ \  __\\ \ \-.  \/_/\ \/\ \ \/\ \    \ \ \-./\ \ \ \/\ \ \  __<\ \ \
          \ \_\ \ \_\ \_____\ \_\ \ \_\ \_____\ \_\\"\_\ \ \_\ \ \_____\    \ \_\ \ \_\ \_____\ \_\ \_\ \_\
           \/_/  \/_/\/_____/\/_/  \/_/\/_____/\/_/ \/_/  \/_/  \/_____/     \/_/  \/_/\/_____/\/_/ /_/\/_/

        __    __  ______  __    __  ______  __   __  ______  ______       __   ____  __   ________  ______  ______
       /\ "-./  \/\  ___\/\ "-./  \/\  ___\/\ "-.\ \/\__  _\/\  __ \     /\ \ / /\ \/\ \ / /\  ___\/\  == \/\  ___\
       \ \ \-./\ \ \  __\\ \ \-./\ \ \  __\\ \ \-.  \/_/\ \/\ \ \/\ \    \ \ \'/\ \ \ \ \'/\ \  __\\ \  __<\ \  __\
        \ \_\ \ \_\ \_____\ \_\ \ \_\ \_____\ \_\\"\_\ \ \_\ \ \_____\    \ \__| \ \_\ \__| \ \_____\ \_\ \_\ \_____\
         \/_/  \/_/\/_____/\/_/  \/_/\/_____/\/_/ \/_/  \/_/  \/_____/     \/_/   \/_/\/_/   \/_____/\/_/ /_/\/_____/

    __   __  ______  __     __       __  ______  ______       __  __  ______  __  __  ______       ______  __  __  ______  __   __
   /\ "-.\ \/\  __ \/\ \  _ \ \     /\ \/\__  _\/\  ___\     /\ \_\ \/\  __ \/\ \/\ \/\  == \     /\__  _\/\ \/\ \/\  == \/\ "-.\ \
   \ \ \-.  \ \ \/\ \ \ \/ ".\ \    \ \ \/_/\ \/\ \___  \    \ \____ \ \ \/\ \ \ \_\ \ \  __<     \/_/\ \/\ \ \_\ \ \  __<\ \ \-.  \
    \ \_\\"\_\ \_____\ \__/".~\_\    \ \_\ \ \_\ \/\_____\    \/\_____\ \_____\ \_____\ \_\ \_\      \ \_\ \ \_____\ \_\ \_\ \_\\"\_\
     \/_/ \/_/\/_____/\/_/   \/_/     \/_/  \/_/  \/_____/     \/_____/\/_____/\/_____/\/_/ /_/       \/_/  \/_____/\/_/ /_/\/_/ \/_/
      ]]

      dashboard.section.header.val = vim.split(logo, "\n")
      dashboard.section.buttons.val = {
        dashboard.button("s", " " .. " Restore Session", [[<cmd>lua require("persistence").load()<cr>]]),
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
          require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
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
  },
  {
    "denstiny/colorful-winsep.nvim",
    enabled = is_enabled("winsep"),
    event = { "WinNew" },
    config = function()
      require("colorful-winsep").setup({
        -- highlight = {
        --   bg = "#16161E",
        --   fg = "#1F3442",
        -- },
        -- timer refresh rate
        interval = 0,
        -- This plugin will not be activated for filetype in the following table.
        no_exec_files = { "packer", "TelescopePrompt", "mason", "CompetiTest", "NvimTree" },
        -- Symbols for separator lines, the order: horizontal, vertical, top left, top right, bottom left, bottom right.
        symbols = { "━", "┃", "┏", "┓", "┗", "┛" },
        -- close_event = function()
        --   -- Executed after closing the window separator
        -- end,
        -- create_event = function()
        --   -- Executed after creating the window separator
        -- end,
      })
    end,
  },
  {
    "nullchilly/fsread.nvim",
    enabled = is_enabled("bionic"),
    lazy = false,
    -- config = function(_, opts)
    --   -- require('').setup(opts)
    -- end
  },
  {
    "nvim-lualine/lualine.nvim",
    enabled = is_enabled("lualine"),
    event = { "BufReadPost" },
    dependencies = {
      "arkav/lualine-lsp-progress"
    },
    lazy = false,
    config = function()
      local disable = { "neogitstatus", "netrw", "lir", "lazy", "alpha", "Outline", "NeogitStatus", "NeogitCommitMessage" }
      local ignore = { "help", "packer", "spectre_panel", "TelescopePrompt" }

      local function active_clients()
        local clients = vim.lsp.buf_get_clients()
        local client_names = {}
        for _, client in pairs(clients) do
          if client.name ~= "null-ls" then
            table.insert(client_names, client.name)
          end
        end
        return #client_names > 0 and table.concat(client_names, ", ") or ""
      end

      local function hide_in_width()
        return false --vim.fn.winwidth(0) < 80
      end

      local diagnostics = {
        diagnostics = true,
        sources = { "nvim_diagnostic" },
        sections = { "error", "warn" },
        symbols = { error = " ", warn = " " },
        colored = false,
        disabled_buftypes = { "nvim-tree" },
        padding = 0,
        update_in_insert = false,
        always_visible = true,
      }

      local diff = {
        diff = true,
        colored = false,
        disabled_buftypes = { "nvim-tree" },
        cond = hide_in_width,
      }

      local branch = {
        "b:gitsigns_head",
        icon = " ",
        disabled_buftypes = { "nvim-tree" },
        cond = hide_in_width,
      }

      local filetype = {
        filetype = true,
        icon_only = true,
        disabled_buftypes = { "nvim-tree" },
        colored = false,
        cond = hide_in_width,
      }

      local language_server = {
        active_clients,
        disabled_buftypes = { "nvim-tree" },
        cond = hide_in_width,
      }

      local lsp_progress = {
        lsp_progress = true,
        display_components = { { "title", "percentage", "message" } },
        timer = { progress_enddelay = 500, lsp_client_name_enddelay = 500 },
      }

      local opts = {
        options = {
          -- theme = "no-clown-fiesta",
          theme = "auto",
          globalstatus = true,
          icons_enabled = false,
          ignore_focus = ignore,
          component_separators = "",
          always_divide_middle = true,
          disabled_filetypes = disable,
          section_separators = { left = "", right = "" },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { branch, diff },
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {},
          -- lualine_x = { lsp_progress, language_server, diagnostics },
          -- lualine_y = { filetype },
          -- lualine_z = { "location", "progress" },
        },
        inactive_sections = {
          lualine_a = { "mode" },
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = { "location", "progress" },
        },
        extensions = {},
      }

      require("lualine").setup(opts) --, { require("nvim-web-devicons"), require("lualine-lsp-progress") })
    end
  }
}
