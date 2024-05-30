require("global")

return {
  {
    dir = "~/code/github/nightcoder.nvim",
    lazy = false,
    enabled = Is_enabled("nightcoder"),
    config = function()
      require("nightcoder").setup()
    end,
  },
  {
    dir = "~/code/github/complexity.nvim",
    lazy = false,
    enabled = false, -- Is_enabled("nightcoder"),
    config = function()
      require("complexity").setup()
    end,
  },
  {
    "koenverburg/minimal-tabline.nvim",
    branch = "develop",
    event = LoadOnBuffer,
    -- dir = "~/code/github/minimal-tabline.nvim",
    enabled = Is_enabled("minimal-tabline"),
    lazy = true,
    opts = {
      enabled = true,
      file_name = false,
      tab_index = true,
      pane_count = false,
      modified_sign = true,
      no_name = "[No Name]",
    },
    config = function(_, opts)
      -- vim.cmd [[ hi TabLine     ctermfg=none ctermbg=none gui=none cterm=none term=none ]]
      -- vim.cmd [[ hi TabLineSel  ctermfg=none ctermbg=none gui=none cterm=none term=none ]]
      -- vim.cmd [[ hi TabLineFill ctermfg=none ctermbg=none gui=none cterm=none term=none ]]
      require("minimal-tabline").setup(opts)
    end,
  },
  {
    -- "koenverburg/minimal-statusline.nvim",
    dir = "~/code/github/minimal-statusline.nvim",
    enabled = Is_enabled("minimal-statusline"),
    lazy = false,
    config = function()
      require("minimal-statusline").setup()
    end,
  },
  {
    "koenverburg/peepsight.nvim",
    branch = "update",
    -- dir = "~/code/github/peepsight.nvim",
    enabled = Is_enabled("peepsight"),
    cmd = "Peepsight",
    config = function()
      require("peepsight").setup({
        -- markdown
        "paragraph",

        -- go
        "function_declaration",
        "method_declaration",
        "func_literal",

        -- shared
        -- "if_statement", -- go, js, ts

        -- JavaScript / TypeScript
        "class_declaration",
        "method_definition",
        "arrow_function",
        "function_declaration",
        "generator_function_declaration",
      })
    end,
  },
  {
    "koenverburg/cmd-palette.nvim",
    enabled = Is_enabled("cmd-palette"),
    cmd = "CmdPalette",
    config = function()
      require("cmd-palette").setup({
        { label = "Peepsight", cmd = "Peepsight" },
        {
          label = "reset",
          callback = function()
            vim.cmd([[ set number ]])
            vim.o.signcolumn = "yes"
          end,
        },
        {
          label = "telescope - filter - Payments",
          callback = function()
            require("experiments.edit-alt").filter_for("payment")
          end,
        },
        {
          label = "telescope - filter - Payments widget",
          callback = function()
            require("experiments.edit-alt").filter_for("payment widget")
          end,
        },
        {
          label = "telescope - filter - widget",
          callback = function()
            require("experiments.edit-alt").filter_for("widget")
          end,
        },
        {
          label = "telescope - filter - nvim",
          callback = function()
            require("experiments.edit-alt").filter_for("nvim")
          end,
        },
        {
          label = "telescope - filter - typescript",
          callback = function()
            require("experiments.edit-alt").filter_for(".ts")
          end,
        },
        {
          label = "telescope - filter - lua",
          callback = function()
            require("experiments.edit-alt").filter_for(".lua")
          end,
        },
        {
          label = "conceal",
          callback = function()
            if vim.o.conceallevel > 0 then
              vim.o.conceallevel = 0
            else
              vim.o.conceallevel = 2
            end
          end,
        },
        {
          label = "Edit in new tab",
          callback = function()
            vim.cmd(":tabedit %|tabprev|:q")
          end,
        },
        {
          label = "Term",
          callback = function()
            local Terminal = require("toggleterm.terminal").Terminal
            local lazygit = Terminal:new({
              cmd = "lazygit",
              dir = "git_dir",
              direction = "float",
              float_opts = {
                border = "double",
              },
              -- function to run on opening the terminal
              on_open = function(term)
                vim.cmd("startinsert!")
                vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
              end,
              -- function to run on closing the terminal
              on_close = function(term)
                vim.cmd("startinsert!")
              end,
            })
            lazygit:toggle()
          end,
        },
      })
    end,
  },
}
