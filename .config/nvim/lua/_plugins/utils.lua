local is_enabled = require("_apache.functions").is_enabled

return {
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
    config = function()
      require("nvim-surround").setup()
    end,
  },
  -- {
  --   "mg979/vim-visual-multi",
  --   enabled = is_enabled("multi-cursor"),
  --   config = function()
  --     -- require("v").setup()
  --   end,
  -- },
}
