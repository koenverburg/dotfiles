require("global")

local plugin = "static"

return {
  {
    -- "koenverburg/static.nvim",
    dir = "~/code/github/static.nvim",
    lazy = false,
    keys = {
      { "<leader>fi", "<cmd>lua require('static.treesitter').fold_imports()<cr>", desc = "Static - fold imports" },
      { "<leader>fr", "<cmd>lua require('static.treesitter').region()<cr>", desc = "Static - fold regions" },
    },
    enabled = false, -- Is_enabled(plugin),
    config = function()
      require("static").setup()
    end,
  },
}
