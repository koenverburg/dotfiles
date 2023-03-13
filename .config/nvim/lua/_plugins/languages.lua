is_enabled = require('_apache.functions').is_enabled

return {
  {
    "elzr/vim-json",
    enabled = is_enabled('languages')
  },
  {
    "jidn/vim-dbml",
    enabled = is_enabled('languages')
  },
    {
    "stephpy/vim-yaml",
    enabled = is_enabled('languages')
  },
    {
    "PProvost/vim-ps1",
    enabled = is_enabled('languages')
  },
    {
    "ekalinin/Dockerfile.vim",
    enabled = is_enabled('languages')
  },
}
