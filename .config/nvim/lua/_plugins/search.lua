require("global")
local ts_settings = require('logic.telescope-settings')

-- "ThePrimeagen/git-worktree.nvim"
return {
  "nvim-telescope/telescope-ui-select.nvim",
  {
    "windwp/nvim-spectre",
    enabled = Is_enabled("search"),
    config = function() end,
  },
  {
    "nvim-telescope/telescope.nvim",
    enabled = Is_enabled("telescope"),
    lazy = false,
    dependencies = {
      "nvim-lua/popup.nvim",
      "nvim-lua/plenary.nvim",
    },
    config = function()
      local ts = require("telescope")

      ts.setup({
        defaults = ts_settings.default,
        extensions = {
          fzf = {
            fuzzy = false,                  -- false will only do exact matching
            override_file_sorter = true,    -- override the file sorter
            override_generic_sorter = true, -- override the generic sorter
            case_mode = "ignore_case",      -- or "ignore_case" or "respect_case", the default case_mode is "smart_case"
          },
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({
              layout_config = {
                width = 0.6,
                height = 0.6,
                prompt_position = "top",
              },
            }),
          },
        },
      })

      require("telescope").load_extension("fzf")
      require("telescope").load_extension("ui-select")
      require("telescope").load_extension("possession")
    end,
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    enabled = Is_enabled("telescope"),
    lazy = false,
    build = "make",
  },
}
