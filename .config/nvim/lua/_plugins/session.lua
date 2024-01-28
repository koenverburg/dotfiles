require("global")
-- local core = require("core.config")

return {
  {
    "RutaTang/spectacle.nvim",
    lazy = false,
    enabled = Is_enabled("session"),
    config = function()
      require("spectacle").setup({})
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
  },
  {
    "jedrzejboczar/possession.nvim",
    lazy = false,
    enabled = Is_enabled("possession"),
    opts = {
      session_dir = vim.fn.getcwd() .. "/.possession"
    },
    config = function(_, opts)
      require('possession').setup(opts)
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  {
    "folke/persistence.nvim",
    enabled = Is_enabled("persistence"),
    lazy = false,
    event = "BufReadPre", -- this will only start session saving when an actual file was opened
    config = function()
      require("persistence").setup({
        dir = vim.fn.expand(vim.fn.stdpath("data") .. "/sessions/"), -- directory where session files are saved
        options = { "buffers", "curdir", "tabpages" },               -- sessionoptions used for saving
        -- pre_save = nil, -- a function to call before saving the session
      })
    end,
  },
}
