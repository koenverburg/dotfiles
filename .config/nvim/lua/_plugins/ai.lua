local is_enabled = require("_apache.functions").is_enabled

return {
  -- AI
  {
    "Exafunction/codeium.vim",
    enabled = is_enabled('codeium'),
    lazy = false,
    config = function()
      -- Change '<C-g>' here to any keycode you like.
      vim.keymap.set("i", "<C-g>", function()
        return vim.fn["codeium#Accept"]()
      end, { expr = true })
      vim.keymap.set("i", "<c-;>", function()
        return vim.fn["codeium#CycleCompletions"](1)
      end, { expr = true })
      vim.keymap.set("i", "<c-,>", function()
        return vim.fn["codeium#CycleCompletions"](-1)
      end, { expr = true })
      vim.keymap.set("i", "<c-x>", function()
        return vim.fn["codeium#Clear"]()
      end, { expr = true })
    end,
  },
  -- {
  --   "sourcegraph/sg.nvim",
  --   enabled = is_enabled('sg'),
  --   lazy = false,
  --   dependencies = { "nvim-lua/plenary.nvim" },
  --
  --   -- If you have a recent version of lazy.nvim, you don't need to add this!
  --   -- build = "nvim -l build/init.lua",
  -- },
  {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    enabled = is_enabled('chatgpt'),
    config = function()
      local file = vim.fn.readfile("/Users/verbukoe/.chatgpt")
      if file then
        require("chatgpt").setup({
          api_key_cmd = file[1]
        })
      else
        print('No chatgpt token found')
      end
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
  },
}
