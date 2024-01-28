require("global")
local normal = require("logic.functions").normal

local plugin = "nvim-navbuddy"

-- if Is_enabled(plugin) then
--   normal("<leader>jd", "<cmd>lua require('nvim-navbuddy').open()<cr>")
-- end

return {
  "SmiteshP/" .. plugin,
  enabled = Is_enabled(plugin),
  keys = {
    { "<leader>jf", "<cmd>lua require('nvim-navbuddy').opne()<cr>", desc = "Navbuddy open" },
  },
  lazy = false,
  dependencies = {
    "SmiteshP/nvim-navic",
    "MunifTanjim/nui.nvim",
  },
  opts = function() end,
}
