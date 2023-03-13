local core = {
  env = {
    isWorkLaptop = string.find(vim.loop.os_gethostname(), "AMS")
  },

  colors = {
    yellow = '#FFCC00',
    black = '#888888'
  },

  treesitter_grammers = {},
  lsp_servers = {},

  plugins = {
    -- Personal
    ["peepsight"]          = { enabled = true },
    ["cmd-palette"]        = { enabled = true },
    ["minimal-tabline"]    = { enabled = true },
    ["minimal-statusline"] = { enabled = true },

    -- Colorschemes
    ["nebulous"] = { enabled = true },
    ["kimbox"]   = { enabled = false },

    -- Search
    ["telescope"] = { enabled = true },
    ["search"]    = { enabled = true },


    -- lsp
    ["lsp"]            = { enabled = true },
    ["lsp-snippets"]   = { enabled = true },
    ["lsp-formatting"] = { enabled = true },

    -- Tree Sitter
    ["treesitter"] = { enabled = true },

    -- UI
    ["expressline"] = { enabled = false },
    ["dressing"] = { enabled = true },
    ["indent-blankline"] = { enabled = true },
    ["smoothcursor"] = { enabled = true },
    ["smartcolumn"] = { enabled = false},
    ["notify"] = { enabled = true },
    ["noice"] = { enabled = true },
    ["dashboard"] = { enabled = true },
    ["explorer"]    = { enabled = true },
    -- Languages
    ["languages"] = { enabled = true },

    -- Misc
    ['misc'] = { enabled = true },
    ["icons"] = { enabled = true },
    ["tint"] = { enabled = true},
    ["accelerated-jk"] = { enabled = true},
    ["hydra"] = { enabled = true},
    ["template"] = { enabled = false },
    ["comment"] = { enabled = true },
    ["murmur"] = { enabled = true },
    ["persistence"] = { enabled = true },

    -- AI
    ["codeium"] = { enabled = false },

    ["git"] = { enabled = true },
  }
}

return core
