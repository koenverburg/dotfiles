local is_enabled = require("logic.functions").is_enabled

return {
  {
    "Wansmer/treesj",
    keys = { "<space>m", "<space>j", "<space>s" },
    enabled = is_enabled("treesj"),
    config = function()
      require("treesj").setup({})
    end,
  },
  {
    "ckolkey/ts-node-action",
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
      "anuvyklack/hydra.nvim",
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
    enabled = is_enabled('toggleterm'),
    opts = {
      --[[ things you want to change go here]]
    },
  },
  {
    "trimclain/builder.nvim",
    cmd = "Build",
    -- stylua: ignore
    -- keys = {
    --   { "<C-b>", function() require("builder").build() end, desc = "Build" }
    -- },
    opts = {
      type = "vert",
      -- percentage of width/height for type = "vert"/"bot" between 0 and 1
      size = 0.25,
      -- size of the floating window for type = "float"
      float_size = {
        height = 0.8,
        width = 0.8,
      },
      -- which border to use for the floating window (see `:help nvim_open_win`)
      float_border = "none",
      -- show/hide line numbers in the Builder buffer
      line_number = false,
      -- automatically save before building
      autosave = true,
      -- keymaps to close the builder buffer, same format as for vim.keymap.set
      close_keymaps = { "q", "<Esc>" },
      -- measure the time it took to build (currently enabled only on linux)
      measure_time = true,
      -- commands for building each filetype; see below
      -- for lua and vim filetypes `:source %` will be used by default
      commands = {
        typescript = "dum jest --config=frontend/jest.frontend.json %s",
        typescriptreact = "dum jest --config=frontend/jest.frontend.json %s",
      },
    },
  },
}
