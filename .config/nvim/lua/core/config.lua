local core = {
  env = {
    isWorkLaptop = string.find(vim.loop.os_gethostname(), "AMS") ~= nil
  },

  signs = {
    error = "",
    warn = "",
    hint = "",
    info = "",
    git = " ",
    searchProject = "󰺅",
    searchFiles = "󰱽",
    searchText = "󱎸",
    notebook = "",
    recentfiles = "󱋢",
    cog = "",
    org = "",
    checkmark = "",
    rightArrow = "",
    smallRightArrow = "",
    guillemet = "»",
    close = "",
    gitAdd = "|",
    gitDelete = "_",
    gitTopDelete = "‾",
    gitChangeDelete = "~",
    gitUntracked = "┆",
    telescope = "",
    caret = ">",
    cmd = "",
    lightning = "",
    document = "",
    import = "",
    keyboard = "",
    sleep = "󰒲",
    filledOrb = "●",
    orb = "○",
    package = "󰏗",
    vim = "",
    code = "",
    play = "",
    star = "",
    line = "‒",
    ignored = "",
    unstaged = "",
    staged = "",
    conflict = "",
  },

  icons = {
    Class = "",
    Constructor = "",
    Function = "󰊕",
    Keyword = "",
    Method = "",
    Module = "",
    Field = "",
    Snippet = "󰘖",
    Text = "",
    Variable = "",
  },

  diagnosticSigns = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" }
  },

  colors = {
    yellow = '#FFCC00',
    black = '#888888'
  },

  lsp_servers = {},

  treesitter_grammers = {},

  supported_languages = {
    "lua",
    -- "javascript",
    -- "javascriptreact",
    "typescript",
    "typescriptreact",
    "tsx",
  },

  plugins = {
    -- Personal
    ["nightcoder"]         = { enabled = false },
    ["peepsight"]          = { enabled = true },
    ["cmd-palette"]        = { enabled = true },
    ["minimal-tabline"]    = { enabled = true },
    ["minimal-statusline"] = { enabled = true },
    ["static"]             = { enabled = true },

    -- Colorschemes
    ["themery"]            = { enabled = false },
    ["auto-colorscheme"]   = { enabled = false },

    ["github"]             = { enabled = false },
    ["no-clown-fiesta"]    = { enabled = true },
    ["nebulous"]           = { enabled = false },
    ["gruvbox"]            = { enabled = false },
    ["darcula"]            = { enabled = false },

    -- Search
    ["telescope"]          = { enabled = true },
    ["search"]             = { enabled = true },

    -- lsp
    ["lsp"]                = { enabled = true },
    ["lsp-snippets"]       = { enabled = true },
    ["lsp-formatting"]     = { enabled = true },
    ["formatting"]         = { enabled = true },

    -- Tree Sitter
    ["treesitter"]         = { enabled = true },

    -- UI
    ["indent-blankline"]   = { enabled = true },
    ["pretty-fold"]        = { enabled = true },

    ["noice"]              = { enabled = true },

    ["dashboard"]          = { enabled = true },
    ["explorer"]           = { enabled = true },

    -- Focus
    ["tint"]               = { enabled = false },

    -- Misc
    ['misc']               = { enabled = true },
    ['colorizer']          = { enabled = false },
    ['leap']               = { enabled = false },
    ["icons"]              = { enabled = true },
    ["accelerated-jk"]     = { enabled = true },
    ["template"]           = { enabled = false },
    ["comment"]            = { enabled = true },
    ["cursorword"]         = { enabled = true },
    ['refactoring']        = { enabled = true },

    -- AI
    ["sg"]                 = { enabled = false },
    ["codeium"]            = { enabled = false },
    ["chatgpt"]            = { enabled = false },

    -- Sessions
    ["possession"]         = { enabled = true },
    ["session"]            = { enabled = false },
    ["persistence"]        = { enabled = false },

    -- Utils
    ["git"]                = { enabled = true },
    ["treesj"]             = { enabled = true },
    ["mini-hipatterns"]    = { enabled = true },
    ["surround"]           = { enabled = true },
    ["ts-node-action"]     = { enabled = true },
    ["multicursors"]       = { enabled = false },
    ["toggleterm"]         = { enabled = true },

    -- Focus (create focus.lua)
    ["centerpad"]          = { enabled = true },

    -- navigation
    ["tabtree"]            = { enabled = true },
    ["tmux"]               = { enabled = true },
    ['hop']                = { enabled = true }, -- move
    ["hydra"]              = { enabled = true }, -- move
    ["nvim-window"]        = { enabled = true },
    ["nvim-navbuddy"]      = { enabled = true },
  }
}

return core
