:lua << EOF
  require 'nvim-treesitter.install'.compilers = { "cc1", "clang", "gcc" }

  require'nvim-treesitter.configs'.setup {
    ensure_installed = {
      "typescript",
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
      disable = { "c", "rust" },  -- list of language that will be disabled
    },
  }
EOF
