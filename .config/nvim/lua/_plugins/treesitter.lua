is_enabled = require("_apache.functions").is_enabled

return {
  {
    "nvim-treesitter/nvim-treesitter",
    version = false,
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    enabled = is_enabled "treesitter",
    dependencies = {
      "nvim-treesitter/playground",
      -- {
      --   "nvim-treesitter/nvim-treesitter-textobjects"
      -- }
    },

    opts = {
      highlight = { enable = true, additional_vim_regex_highlighting = true },
      indent = { enable = true },
      ensure_installed = {
        "vim",
        "regex",
        "css",
        "go",
        "query",
        "graphql",
        "html",
        "javascript",
        "jsdoc",
        "json",
        "markdown",
        "markdown_inline",
        "tsx",
        "typescript",
        "yaml",
        "lua",
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
    },

    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}
