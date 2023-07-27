local core = {
  env = {
    isWorkLaptop = string.find(vim.loop.os_gethostname(), "AMS")
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
   cmd =  "",
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
    {name = "DiagnosticSignError", text = ""},
    {name = "DiagnosticSignWarn", text = ""},
    {name = "DiagnosticSignHint", text = ""},
    {name = "DiagnosticSignInfo", text = ""}
  },

  colors = {
    yellow = '#FFCC00',
    black = '#888888'
  },

  lsp_servers = {},
  treesitter_grammers = {},

  plugins = {
    -- Personal
    ["peepsight"]          = { enabled = true },
    ["cmd-palette"]        = { enabled = true },
    ["minimal-tabline"]    = { enabled = true },
    ["minimal-statusline"] = { enabled = false },

    -- Colorschemes
    ["auto-colorscheme"] = { enabled = false },
    ["no-clown-fiesta"]  = { enabled = true },
    ["nebulous"]         = { enabled = false },
    ["gruvbox"]          = { enabled = false },
    ["kimbox"]           = { enabled = false },
    ["gruvbuddy"]        = { enabled = false },


    -- Search
    ["telescope"] = { enabled = true },
    ["search"]    = { enabled = true },


    -- lsp
    ["lsp"]            = { enabled = true },
    ["lsp-snippets"]   = { enabled = true },
    ["lsp-formatting"] = { enabled = true },
    ["formatting"]     = { enabled = true },

    -- Tree Sitter
    ["treesitter"] = { enabled = true },

    -- UI
    ["expressline"]      = { enabled = true },
    ["lualine"]          = { enabled = false },
    ["dressing"]         = { enabled = false }, -- turning off because of noice
    ["indent-blankline"] = { enabled = true },
    ["smoothcursor"]     = { enabled = false },
    ["smartcolumn"]      = { enabled = false},
    ["bionic"]           = { enabled = true },

    ["noice"]  = { enabled = true },
    ["notify"] = { enabled = false },

    ["dashboard"] = { enabled = true },
    ["explorer"]  = { enabled = true },

    -- Focus
    ["tint"]   = { enabled = false },

    -- Languages
    ["languages"] = { enabled = true },

    -- Misc
    ['misc']           = { enabled = true },
    ['colorizer']      = { enabled = true },
    ['hop']            = { enabled = true },
    ['leap']           = { enabled = false },
    ["icons"]          = { enabled = true },
    ["accelerated-jk"] = { enabled = true},
    ["hydra"]          = { enabled = true},
    ["template"]       = { enabled = false },
    ["comment"]        = { enabled = true },
    ["cursorword"]     = { enabled = true },

    -- AI
    ["sg"]      = { enabled = false },
    ["codeium"] = { enabled = false },
    ["chatgpt"] = { enabled = false },


    -- Sessions
    ["session"]     = { enabled = false },
    ["possession"]  = { enabled = true },
    ["persistence"] = { enabled = false },

    -- Utils
    ["git"] = { enabled = true },
    ["treesj"] = { enabled = true },
  }
}

return core
