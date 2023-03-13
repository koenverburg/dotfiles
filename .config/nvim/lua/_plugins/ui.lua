is_enabled = require("_apache.functions").is_enabled

return {
  {
    "stevearc/dressing.nvim",
    enabled = is_enabled("dressing"),
    init = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.select(...)
      end
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.input = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.input(...)
      end
    end,
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

    config = function()
      require("nebulous").setup({
        variant = "night",
      })
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
      -- vim.cmd([[set fillchars+=vert:┃]])
      -- vim.cmd([[set fillchars+=horiz:━]])
      vim.cmd([[set fillchars+=stl:━]])

      -- vim.cmd([[set fillchars+=horizup:┻]])
      -- local helper = require "el.helper"
      local subscribe = require("el.subscribe")
      local extensions = require("el.extensions")
      local builtin = require("el.builtin")
      local sections = require("el.sections")
      local hi = sections.highlight
      local line = " "

      local git_branch = subscribe.buf_autocmd("el_git_branch", "BufEnter", function(window, buffer)
        local branch = extensions.git_branch(window, buffer)
        if branch then
          return " " .. extensions.git_icon() .. " " .. branch
        end
      end)

      local shortened_file = function(_, buffer)
        if buffer.name == "" then
          return builtin.file(_, buffer)
        end

        if string.len(vim.fn.fnamemodify(buffer.name, ":.")) > 50 then
          return vim.fn.fnamemodify(buffer.name, ":t")
        end

        return vim.fn.fnamemodify(buffer.name, ":.")
      end

      local show_lsp_status = function(_, buffer)
        local buffer_clients = vim.lsp.buf_get_clients(buffer.bufnr)
        local attached_lsps = {}

        for _, v in pairs(buffer_clients) do
          table.insert(attached_lsps, v.name)
        end

        if #attached_lsps == 0 then
          return ""
        end

        local lsps = table.concat(attached_lsps, ",")

        return " lsp (" .. lsps .. ") "
      end

      local generator = function(_, _) -- window, bufnr
        local segments = {}

        table.insert(segments, line)
        table.insert(segments, extensions.mode)
        table.insert(segments, git_branch)
        table.insert(segments, line)

        table.insert(segments, sections.split)
        table.insert(segments, line)
        table.insert(segments, shortened_file)
        table.insert(segments, builtin.modified)
        table.insert(segments, line)
        table.insert(
          segments,
          subscribe.buf_autocmd("el_file_icon", "BufRead", function(_, buffer)
            return extensions.file_icon(_, buffer)
          end)
        )
        table.insert(segments, line)

        table.insert(segments, sections.split)
        table.insert(segments, show_lsp_status)
        table.insert(segments, sections.collapse_builtin(builtin.help_list, builtin.readonly_list))
        table.insert(segments, line)

        table.insert(segments, builtin.line)
        table.insert(segments, "/")
        table.insert(segments, builtin.number_of_lines)
        table.insert(segments, line)

        table.insert(segments, builtin.filetype)
        table.insert(segments, line)

        -- table.insert(
        --   segments,
        --   subscribe.buf_autocmd("el_git_status", "BufWritePost", function(window, buffer)
        --     local changes = extensions.git_changes(window, buffer)
        --     if changes then
        --       return " " .. changes .. " "
        --     end
        --   end)
        -- )
        --
        return segments
      end
      require("el").setup({
        generator = generator,
        regenerate_autocmds = { "WinEnter", "WinLeave", "DiagnosticChanged", "ModeChanged", "BufEnter", "BufWritePost" },
      })

      local highlight = function(group, properties)
        local fg = properties.fg == nil and "" or "guifg=" .. properties.fg
        local bg = properties.bg == nil and "" or "guibg=" .. properties.bg
        local style = properties.style == nil and "" or "gui=" .. properties.style
        local cmd = table.concat({ "highlight", group, bg, fg, style }, " ")
        vim.cmd(cmd)
      end

      local colors_keys = {
        Statusline = { fg = "none", bg = "none", style = "none" },
        -- ElInsert = { fg = "none", bg = "none", style = "none" },
      }

      for hl, col in pairs(colors_keys) do
        highlight(hl, col)
      end

      vim.api.nvim_create_autocmd({ "WinEnter", "WinLeave", "DiagnosticChanged", "ModeChanged", "BufEnter", "BufWritePost" }, {
        pattern = "*",
        callback = function()
          for hl, col in pairs(colors_keys) do
            highlight(hl, col)
          end
        end,
      })
    end,
  },
    {
    "gen740/SmoothCursor.nvim",
    lazy = false,
    enabled = is_enabled('smoothcursor'),
    opts = {
      autostart = true,
      cursor = "", -- cursor shape (need nerd font)
      texthl = "SmoothCursor", -- highlight group, default is { bg = nil, fg = "#FFD400" }
      linehl = nil, -- highlight sub-cursor line like 'cursorline', "CursorLine" recommended
      type = "default", -- define cursor movement calculate function, "default" or "exp" (exponential).
      fancy = {
        enable = true, -- enable fancy mode
        head = { cursor = "", texthl = "SmoothCursor", linehl = nil },
        body = {
          { cursor = "", texthl = "SmoothCursorRed" },
          { cursor = "", texthl = "SmoothCursorOrange" },
          { cursor = "●", texthl = "SmoothCursorYellow" },
          { cursor = "●", texthl = "SmoothCursorGreen" },
          { cursor = "•", texthl = "SmoothCursorAqua" },
          { cursor = ".", texthl = "SmoothCursorBlue" },
          { cursor = ".", texthl = "SmoothCursorPurple" },
        },
        tail = { cursor = nil, texthl = "SmoothCursor" },
      },
      flyin_effect = nil, -- "bottom" or "top"
      speed = 25, -- max is 100 to stick to your current position
      intervals = 35, -- tick interval
      priority = 10, -- set marker priority
      timeout = 3000, -- timout for animation
      threshold = 3, -- animate if threshold lines jump
      disable_float_win = false, -- disable on float window
      enabled_filetypes = nil, -- example: { "lua", "vim" }
      disabled_filetypes = nil, -- this option will be skipped if enabled_filetypes is set. example: { "TelescopePrompt", "NvimTree" }
    },
    config = function(_, opts)
      require("smoothcursor").setup(opts)
    end
  },
  {
    "m4xshen/smartcolumn.nvim",
    lazy = false,
    enabled = is_enabled('smartcolumn'),
    opts = {
      colorcolumn = 80,
      limit_to_line = false,
      limit_to_window = false,
      custom_colorcolumn = {},
      disabled_filetypes = { "help", "text", "markdown" },
    },
    config = function(_, opts)
      require("smartcolumn").setup(opts)
    end
  },
  {
    "rcarriga/nvim-notify",
    enabled = is_enabled('notify'),
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
    enabled = is_enabled('noice'),
    lazy = false,
    dependencies = {
      "MunifTanjim/nui.nvim"
    },
    opts = {
      presets = {
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        bottom_search = false, -- use a classic bottom cmdline for search
        lsp_doc_border = false, -- add a border to hover docs and signature help
        command_palette = false, -- position the cmdline and popupmenu together
        long_message_to_split = false, -- long messages will be sent to a split
      },
      cmdline = {
        enabled = true, -- enables the Noice cmdline UI
        view = "cmdline_popup", -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
        format = {
          search_up = { kind = "search", pattern = "^%?", icon = "", lang = "regex" },
          search_down = { kind = "search", pattern = "^/", icon = "", lang = "regex" },

          cmdline = { pattern = "^:", icon = "", lang = "vim" },
          filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
          lua = { pattern = "^:%s*lua%s+", icon = "", lang = "lua" },
          help = { pattern = "^:%s*he?l?p?%s+", icon = "" },
          input = {}, -- Used by input()
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
    enabled = is_enabled('dashboard'),
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
    enabled = is_enabled('explorer'),
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
}
