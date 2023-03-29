local core = {
  env = {
    isWorkLaptop = string.find(vim.loop.os_gethostname(), "AMS")
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
    ["minimal-statusline"] = { enabled = true },

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

    -- Tree Sitter
    ["treesitter"] = { enabled = true },

    -- UI
    ["expressline"] = { enabled = false },
    ["dressing"] = { enabled = true },
    ["indent-blankline"] = { enabled = true },
    ["smoothcursor"] = { enabled = false },
    ["smartcolumn"] = { enabled = false},

    ["noice"] = { enabled = true },
    ["notify"] = { enabled = true },

    ["dashboard"] = { enabled = true },
    ["explorer"]  = { enabled = true },
    ["winsep"]    = { enabled = false },

    -- Languages
    ["languages"] = { enabled = true },

    -- Misc
    ['misc'] = { enabled = true },
    ['hop'] = { enabled = true },
    ['leap'] = { enabled = false },
    ["icons"] = { enabled = true },
    ["tint"] = { enabled = false },
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
