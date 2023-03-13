
require("Comment").setup()

require("auto-session").setup {
  bypass_session_save_file_types = {
    "alpha",
    "NvimTree",
  },
  pre_save_cmds = {
    function()
      -- vim.cmd "tabdo SymbolsOutlineClose"
      -- require("experiments.gc").clean()
    end,
  },
  post_restore_cmds = {
    function()
      vim.schedule(function()
        -- vim.cmd "tabdo SymbolsOutlineOpen"
      end)
    end,
  },
}
