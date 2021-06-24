require('formatter').setup({
  logging = false,
  filetype = {
    typescript = {
      -- eslint
      function()
        return {
          exe = 'eslint_d',
          args = {'--stdin', '--fix-to-stdout', '--stdin-filename', vim.api.nvim_buf_get_name(0) },
          stdin = true
        }
      end
    },
    javascript = {
      -- eslint
      function()
        return {
          exe = 'eslint_d',
          args = {'--stdin', '--fix-to-stdout', '--stdin-filename', vim.api.nvim_buf_get_name(0) },
          stdin = true
        }
      end
    },
    -- lua = {
    --     function()
    --       return {
    --         exe = "luafmt",
    --         args = {"--indent-count", 2, "--stdin"},
    --         stdin = true
    --       }
    --     end
    --   }
  }
})
