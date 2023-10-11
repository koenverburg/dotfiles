local is_enabled = require("_apache.functions").is_enabled

return {
  "antoinemadec/FixCursorHold.nvim",
  {
    "Wansmer/treesj",
    keys = { "<space>m", "<space>j", "<space>s" },
    enabled = is_enabled("treesj"),
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("treesj").setup({})
    end,
  },
  {
    "ckolkey/ts-node-action",
    dependencies = { "nvim-treesitter" },
    enabled = is_enabled("ts-node-action"),
    opts = {},
  },
  {
    "kylechui/nvim-surround",
    enabled = is_enabled("surround"),
    lazy = false,
    config = function()
      require("nvim-surround").setup()
    end,
  },
  {
    "smoka7/multicursors.nvim",
    -- lazy = "VeryLazy",
    enabled = false, -- is_enabled("multicursors"),
    dependencies = {
      -- "smoka7/hydra.nvim",
      "anuvyklack/hydra.nvim"
    },
    opts = {},
    cmd = { "MCstart", "MCvisual", "MCclear", "MCpattern", "MCvisualPattern", "MCunderCursor" },
    keys = {
      {
        mode = { "v", "n" },
        "<Leader>m",
        "<cmd>MCstart<cr>",
        desc = "Create a selection for selected text or word under the cursor",
      },
    },
  },
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
      --[[ things you want to change go here]]
    },
  },
}
