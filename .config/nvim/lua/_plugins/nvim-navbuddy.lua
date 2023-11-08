local is_enabled = require("logic.functions").is_enabled
local normal = require("logic.functions").normal

local plugin = "nvim-navbuddy"

if is_enabled(plugin) then
  normal("<leader>jd", "<cmd>lua require('nvim-navbuddy').open()<cr>")
end

return {
  "SmiteshP/" .. plugin,
  enabled = is_enabled(plugin),
  lazy = false,
  dependencies = {
    "SmiteshP/nvim-navic",
    "MunifTanjim/nui.nvim",
  },
  opts = function() end,
}
