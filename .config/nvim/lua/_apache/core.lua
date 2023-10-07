local ide_enabled = false

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
    ["peepsight"]          = { enabled = true },
    ["cmd-palette"]        = { enabled = true },
    ["minimal-tabline"]    = { enabled = true },
    ["minimal-statusline"] = { enabled = false },

    -- Colorschemes
    ["auto-colorscheme"] = { enabled = true },
    ["no-clown-fiesta"]  = { enabled = true },
    ["nebulous"]         = { enabled = true },

    ["gruvbox"]          = { enabled = false },
    ["kimbox"]           = { enabled = false },
    ["gruvbuddy"]        = { enabled = false },
    ["darcula"]          = { enabled = false },

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
    ["pretty-fold"]      = { enabled = true },

    ["noice"]  = { enabled = true },

    ["dashboard"] = { enabled = not ide_enabled },
    ["explorer"]  = { enabled = true },

    -- Focus
    ["tint"]   = { enabled = false },

    -- Languages
    ["languages"] = { enabled = true },

    -- Misc
    ['misc']           = { enabled = true },
    ['colorizer']      = { enabled = false },
    ['leap']           = { enabled = false },
    ["icons"]          = { enabled = true },
    ["accelerated-jk"] = { enabled = true},
    ["template"]       = { enabled = false },
    ["comment"]        = { enabled = true },
    ["cursorword"]     = { enabled = true },
    ['refactoring']    = { enabled = true },

    -- AI
    ["sg"]      = { enabled = false },
    ["codeium"] = { enabled = false },
    ["chatgpt"] = { enabled = false },

    -- Sessions
    ["session"]     = { enabled = false },
    ["possession"]  = { enabled = true },
    ["persistence"] = { enabled = false },

    -- Utils
    ["git"]             = { enabled = true },
    ["treesj"]          = { enabled = true },
    ["mini-hipatterns"] = { enabled = true },
    ["surround"]        = { enabled = true },
    ["ts-node-action"]  = { enabled = true },
    ["multicursors"]    = { enabled = true },

    ["ide"] = { enabled = ide_enabled },

    -- Focus (create focus.lua)
    ["centerpad"] = { enabled = true },

    -- navigation
    ["tabtree"] = { enabled = true },
    ['hop']     = { enabled = true }, -- move
    ["hydra"]   = { enabled = true}, -- move
  }
}

return core
