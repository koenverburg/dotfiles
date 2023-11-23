local normal = require("logic.functions").normal
local is_enabled = require("logic.functions").is_enabled

local plugin = "static"

if is_enabled(plugin) then
  -- Folding using Treesitter
  normal("<leader>fi", "<cmd>lua require 'static.treesitter'.fold_imports()<cr>")
  normal("<leader>fr", "<cmd>lua require('static.treesitter').region()<cr>")
end

return {
  {
    -- "koenverburg/static.nvim",
    dir = "~/code/github/static.nvim",
    lazy = false,
    enabled = is_enabled(plugin),
    config = function()
      require('static').setup()
    end,
  },
}
