is_enabled = require('_apache.functions').is_enabled

return {
  {
    "lewis6991/gitsigns.nvim",
    enabled = is_enabled('git'),
    event = { "BufReadPre", "BufNewFile" },

    config = function ()
      require("gitsigns").setup({
        signs = {
          add = { hl = "GitSignsAdd", text = "│", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
          change = { hl = "GitSignsChange", text = "│", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
          delete = { hl = "GitSignsDelete", text = "_", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
          topdelete = { hl = "GitSignsDelete", text = "‾", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
          changedelete = { hl = "GitSignsChange", text = "~", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
          untracked = { hl = "GitSignsAdd", text = "│", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" }
        },
        numhl = false,
        linehl = false
      })
    end,
  },
  {
    "TimUntersberger/neogit",
    enabled = is_enabled('git'),

    config = function ()
      require('neogit').setup({
        integrations = {
          diffview = true
        },
      })
    end,
  },
  {
    "sindrets/diffview.nvim",
    enabled = is_enabled('git'),

    config = function () end,
  },
}
