local eslint = {
  -- eslint
  function()
    return {
      exe = 'eslint_d',
      args = {'--stdin', '--fix-to-stdout', '--stdin-filename', vim.api.nvim_buf_get_name(0) },
      stdin = true
    }
  end
}

require'formatter'.setup({
  logging = false,
  filetype = {

    typescript = eslint,
    typescriptreact = eslint,

    javascript = eslint,
    javascriptreact = eslint,
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
