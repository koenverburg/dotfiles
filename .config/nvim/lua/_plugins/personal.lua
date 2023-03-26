is_enabled = require('_apache.functions').is_enabled

return {
  { dir = "~/code/github/nightcoder.nvim" },
  {
    "koenverburg/minimal-tabline.nvim",
    branch = "develop",
    -- dir = "~/code/github/minimal-tabline.nvim",
    enabled = is_enabled('minimal-tabline'),
    lazy = false,
    opts = {
      enabled = true,
      file_name = false,
      tab_index = true,
      pane_count = false,
      modified_sign = true,
      no_name = "[No Name]",
    },
    config = function (_, opts)
      -- vim.cmd [[ hi TabLine     ctermfg=none ctermbg=none gui=none cterm=none term=none ]]
      -- vim.cmd [[ hi TabLineSel  ctermfg=none ctermbg=none gui=none cterm=none term=none ]]
      -- vim.cmd [[ hi TabLineFill ctermfg=none ctermbg=none gui=none cterm=none term=none ]]
      require('minimal-tabline').setup(opts)
    end,
  },
  {
    "koenverburg/minimal-statusline.nvim",
    -- dir = "~/code/github/minimal-statusline.nvim",
    enabled = is_enabled('minimal-statusline'),
    lazy = false,
    -- opts = {
    --   regenerate_autocmds = { "WinEnter", "WinLeave", "ModeChanged", "BufEnter", "BufWritePost" },
    -- },
    config = function ()
      require('minimal-statusline').setup()
    end,
  },
  {
    "koenverburg/peepsight.nvim",
    enabled = is_enabled('peepsight'),

    config = function ()
      require("peepsight").setup {
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
      }
    end,
  },
  {
    "koenverburg/cmd-palette.nvim",
    enabled = is_enabled('cmd-palette'),

    config = function ()
     require("cmd-palette").setup {
      { label = "Peepsight", cmd = "Peepsight" },
      {
        label = "reset",
        callback = function()
          vim.cmd [[ set number ]]
          vim.o.signcolumn = "yes"
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
          vim.cmd ":tabedit %|tabprev|:q"
        end,
      },
    }
    end,
  },
}
