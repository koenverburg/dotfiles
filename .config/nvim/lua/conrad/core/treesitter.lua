require("nvim-treesitter.configs").setup {
  highlight = { enable = true, additional_vim_regex_highlighting = true },
  indent = { enable = true },
  ensure_installed = {
    "css",
    "go",
    "graphql",
    "html",
    "javascript",
    "jsdoc",
    "json",
    "markdown",
    "tsx",
    "typescript",
    "yaml",
    -- "sumneko_lua"
    -- "lua",
  },
  context_commentstring = {
    enable = true,
    config = {
      yml = "# %s",
      yaml = "# %s",

      css = "// %s",
      scss = "// %s",

      js = "// %s",
      ts = "// %s",
      tsx = {
        __default = "// %s",
        jsx_element = "{/* %s */}",
        jsx_fragment = "{/* %s */}",
        jsx_attribute = "{/* %s */}",
        comment = "// %s",
      },
      jsx = {
        __default = "// %s",
        jsx_element = "{/* %s */}",
        jsx_fragment = "{/* %s */}",
        jsx_attribute = "{/* %s */}",
        comment = "// %s",
      },
    },
  },
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        -- keybindings are triggered in visual mode only
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",

        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",

        ["ab"] = "@block.outer",
        ["ib"] = "@block.inner",
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ["<leader>m"] = "@parameter.inner",
      },
      swap_previous = {
        ["<leader>M"] = "@parameter.inner",
      },
    },
    -- revise these commands
    move = {
      enable = true,
      set_jumps = false, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
  },
}
