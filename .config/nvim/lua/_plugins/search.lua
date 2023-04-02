is_enabled = require("_apache.functions").is_enabled

-- "ThePrimeagen/git-worktree.nvim"
return {
  "nvim-telescope/telescope-ui-select.nvim",
  {
    "windwp/nvim-spectre",
    enabled = is_enabled("search"),
    config = function() end,
  },
  {
    "nvim-telescope/telescope.nvim",
    enabled = is_enabled("telescope"),
    dependencies = {
      "nvim-lua/popup.nvim",
      "nvim-lua/plenary.nvim",
    },
    config = function()
      local ts = require("telescope")

      ts.setup({
        defaults = {
          color_devicons = true,
          borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
          sorting_strategy = "ascending",
          layout_config = {
            height = 0.75,
            width = 0.9,
          },
        },
        extensions = {
          fzf = {
            fuzzy = false, -- false will only do exact matching
            override_file_sorter = true, -- override the file sorter
            override_generic_sorter = true, -- override the generic sorter
            case_mode = "ignore_case", -- or "ignore_case" or "respect_case", the default case_mode is "smart_case"
          },
        },
      })

      require("telescope").load_extension("fzf")
      require("telescope").load_extension("ui-select")
    end,
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    enabled = is_enabled("telescope"),
    build = "make",
  },
}
