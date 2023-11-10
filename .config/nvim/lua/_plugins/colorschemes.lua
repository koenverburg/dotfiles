local is_enabled = require("logic.functions").is_enabled

local function mode(theme)
  -- os.execute('cmd')
  return string.format(
    'sed -i "" -e "s#^colors: \\*.*#colors: *%s#g" ~/code/github/dotfiles/.config/alacritty/alacritty.macos.yml',
    theme
  )
end

return {
  {
    "ellisonleao/gruvbox.nvim",
    enabled = is_enabled("gruvbox"),
    lazy = false,
    opts = {
      bold = true,
      undercurl = true,
      underline = true,
      italic = {
        folds = false,
        strings = false,
        comments = false,
        operators = false,
      },
      strikethrough = true,
      invert_signs = false,
      invert_tabline = false,
      invert_selection = false,
      invert_intend_guides = false,
      inverse = true, -- invert background for search, diffs, statuslines and errors
      contrast = "", -- can be "hard", "soft" or empty string
      dim_inactive = false,
      transparent_mode = false,
      overrides = {},
      palette_overrides = {},
    },
    config = function(_, opts)
      vim.cmd("set background=light")
      require("gruvbox").setup(opts)
      vim.cmd("colorscheme gruvbox")
    end,
  },
  {
    "Yagua/nebulous.nvim",
    enabled = is_enabled("nebulous"),
    lazy = false,
    opts = {
      -- variant = "night", -- "night",
      variant = "quasar", -- "night",
    },
    config = function(_, opts)
      if not is_enabled("auto-colorscheme") or not is_enabled("themery") then
        vim.cmd("set background=light")
        require("nebulous").setup(opts)
      end
    end,
  },
  {
    -- "aktersnurra/no-clown-fiesta.nvim",
    -- "koenverburg/no-clown-fiesta.nvim",
    dir = "~/code/github/no-clown-fiesta.nvim",
    enabled = is_enabled("no-clown-fiesta"),
    branch = "personal-touch",
    lazy = false,
    opts = {
      transparent = false, -- Enable this to disable the bg color
      styles = {
        -- You can set any of the style values specified for `:h nvim_set_hl`
        comments = {},
        keywords = {},
        functions = { bold = true },
        variables = {},
        type = { bold = true },
        lsp = { underline = true },
      },
    },
    config = function(_, opts)
      if not is_enabled("auto-colorscheme") or not is_enabled("themery") then
        vim.cmd("set background=dark")
        require("no-clown-fiesta").setup(opts)
        vim.cmd([[colorscheme no-clown-fiesta]])
      end
    end,
  },
  {
    "f-person/auto-dark-mode.nvim",
    enabled = is_enabled("auto-colorscheme"),
    config = {
      update_interval = 1000,
      set_dark_mode = function()
        require("github-theme").setup({})
        vim.cmd("colorscheme github_dark_high_contrast")

        local cmd = mode("github")
        os.execute(cmd)

        -- vim.cmd("set background=dark")
        -- require("no-clown-fiesta").setup({
        --   transparent = false, -- Enable this to disable the bg color
        --   styles = {
        --     -- You can set any of the style values specified for `:h nvim_set_hl`
        --     comments = {},
        --     keywords = {},
        --     functions = { bold = true },
        --     variables = {},
        --     type = { bold = true },
        --     lsp = { underline = true },
        --   },
        -- })
        -- vim.cmd([[colorscheme no-clown-fiesta]])
      end,
      set_light_mode = function()
        require("github-theme").setup({})
        vim.cmd("colorscheme github_light_high_contrast")
        local cmd = mode("githublight")
        os.execute(cmd)
        -- vim.api.nvim_set_option("background", "light")
        -- require("nebulous").setup({
        --   variant = "quasar",
        -- })
      end,
    },
    init = function()
      require("auto-dark-mode").init()
    end,
  },
  {
    "briones-gabriel/darcula-solid.nvim",
    dependencies = {
      "rktjmp/lush.nvim",
    },
    enabled = is_enabled("darcula"),
    lazy = false,
    config = function()
      vim.cmd("colorscheme darcula-solid")
    end,
  },
  {
    "projekt0n/github-nvim-theme",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    enabled = is_enabled("github"),
    config = function()
      if not is_enabled("auto-colorscheme") or not is_enabled("themery") then
        require("github-theme").setup({})
        vim.cmd("colorscheme github_dark")
      end
    end,
  },
  {
    "zaldih/themery.nvim",
    lazy = false,
    enabled = is_enabled("themery"),
    config = function()
      -- Minimal config
      require("themery").setup({
        -- themes = {
        --   -- "nebulous",
        --   "github_dark_high_contrast",
        --   -- "no-clown-fiesta",
        -- },
        themeConfigFile = "~/.config/nvim/lua/conrad/themery.lua", -- Described below
        livePreview = false, -- Apply theme while browsing. Default to true.
      })
    end,
  },
}
