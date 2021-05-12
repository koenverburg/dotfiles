require('nvim-treesitter.configs').setup {
  ensure_installed = {
    "yaml",
    "tsx",
    "typescript",
    "graphql",
    "jsdoc",
    "javascript",
    "html",
    "json",
    "css",
    "lua",
    "go",
  },
  highlight = {
    enable = true,
  },
}
