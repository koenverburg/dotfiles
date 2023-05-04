local core = {
  env = {
    isWorkLaptop = string.find(vim.loop.os_gethostname(), "AMS")
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

  signs = {
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
    ["kimbox"]          = { enabled = false },
    ["nebulous"]        = { enabled = false },
    ["no-clown-fiesta"] = { enabled = true },


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
    ["notify"] = { enabled = true },

    ["dashboard"] = { enabled = true },
    ["explorer"]  = { enabled = true },

    -- Focus
    ["winsep"] = { enabled = false },
    ["tint"]   = { enabled = false },

    -- Languages
    ["languages"] = { enabled = true },

    -- Misc
    ['misc']           = { enabled = true },
    ['hop']            = { enabled = true },
    ['leap']           = { enabled = false },
    ["icons"]          = { enabled = true },
    ["accelerated-jk"] = { enabled = true},
    ["hydra"]          = { enabled = true},
    ["template"]       = { enabled = false },
    ["comment"]        = { enabled = true },
    ["cursorword"]     = { enabled = true },
    ["persistence"]    = { enabled = true },

    -- AI
    ["codeium"] = { enabled = true },

    ["git"] = { enabled = true },
  }
}

return core
