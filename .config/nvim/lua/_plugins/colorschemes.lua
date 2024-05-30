require("global")

local function mode(theme)
  -- os.execute('cmd')
  return string.format(
    'sed -i "" -e "s#^colors: \\*.*#colors: *%s#g" ~/code/github/dotfiles/.config/alacritty/alacritty.macos.yml',
    theme
  )
end

return {
  {
    "Tsuzat/NeoSolarized.nvim",
    enabled = Is_enabled("solarized"),
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      local ok_status, NeoSolarized = pcall(require, "NeoSolarized")
      if not ok_status then
        return
      end

      NeoSolarized.setup({
        style = "light", -- "dark" or "light"
        transparent = false, -- true/false; Enable this to disable setting the background color
        enable_italics = false, -- Italics for different hightlight groups (eg. Statement, Condition, Comment, Include, etc.)
        terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
        styles = {
          -- Style to be applied to different syntax groups
          comments = { italic = false },
          keywords = { italic = false },
          functions = { bold = true },
          variables = {},
          string = { italic = false },
          underline = true, -- true/false; for global underline
          undercurl = true, -- true/false; for global undercurl
        },
        -- Add specific hightlight groups
        on_highlights = function(highlights, colors)
          -- highlights.Include.fg = colors.red -- Using `red` foreground for Includes
        end,
      })
      vim.cmd([[ set background=light ]])
      vim.cmd([[ colorscheme NeoSolarized ]])
    end,
  },
  {
    "ellisonleao/gruvbox.nvim",
    enabled = Is_enabled("gruvbox"),
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
      vim.cmd("set background=dark")
      require("gruvbox").setup(opts)
      vim.cmd("colorscheme gruvbox")
    end,
  },
  {
    "Yagua/nebulous.nvim",
    enabled = Is_enabled("nebulous"),
    lazy = false,
    opts = {
      -- variant = "night", -- "night",
      variant = "quasar", -- "night",
    },
    config = function(_, opts)
      if not Is_enabled("auto-colorscheme") or not Is_enabled("themery") then
        vim.cmd("set background=light")
        require("nebulous").setup(opts)
      end
    end,
  },
  {
    -- "aktersnurra/no-clown-fiesta.nvim",
    -- "koenverburg/no-clown-fiesta.nvim",
    dir = "~/code/github/no-clown-fiesta.nvim",
    enabled = Is_enabled("no-clown-fiesta"),
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
      if not Is_enabled("auto-colorscheme") or not Is_enabled("themery") then
        vim.cmd("set background=dark")
        require("no-clown-fiesta").setup(opts)
        vim.cmd([[colorscheme no-clown-fiesta]])
      end
    end,
  },
  {
    "aktersnurra/no-clown-fiesta.nvim",
    enabled = Is_enabled("default-no-clown-fiesta"),
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
      if not Is_enabled("auto-colorscheme") or not Is_enabled("themery") then
        vim.cmd("set background=dark")
        require("no-clown-fiesta").setup(opts)
        vim.cmd([[colorscheme no-clown-fiesta]])
      end
    end,
  },
  {
    "f-person/auto-dark-mode.nvim",
    enabled = Is_enabled("auto-colorscheme"),
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
    enabled = Is_enabled("darcula"),
    lazy = false,
    config = function()
      vim.cmd("colorscheme darcula-solid")
    end,
  },
  {
    "projekt0n/github-nvim-theme",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    enabled = Is_enabled("github"),
    config = function()
      if not Is_enabled("auto-colorscheme") or not Is_enabled("themery") then
        require("github-theme").setup({})
        vim.cmd("colorscheme github_dark")
      end
    end,
  },
  {
    "zaldih/themery.nvim",
    lazy = false,
    enabled = Is_enabled("themery"),
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
