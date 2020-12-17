require 'nvim-treesitter.configs'.setup {
  ensure_installed = {
    -- "typescript",
    -- "typescript.tsx",
    -- "tsx",
    "javascript",
    "graphql",
    "go",
    "json",
    "lua",
    "css",
    "jsdoc",
    "html",
  }, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
  },
}
