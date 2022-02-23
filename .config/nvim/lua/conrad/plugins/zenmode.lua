require("zen-mode").setup()
require("twilight").setup {
  context = 2,
  expand = { -- for treesitter, we we always try to expand to the top-most ancestor with these types
    -- Lua
    "function",
    "function_name",
    "local_function",
    -- Go
    "function_declaration",
  },
}
