local is_enabled = require("logic.functions").is_enabled
local normal = require("logic.functions").normal

local plugin = "deadcolumn.nvim"

-- if is_enabled(plugin) then
--   normal("<leader>w", "<cmd>lua require('nvim-window').pick()<cr>")
-- end

return {
  "Bekaboo/" .. plugin,
  enabled = is_enabled(plugin),
  event = { "BufReadPre", "BufNewFile" },
  lazy = false,
  opts = function()
    require("deadcolumn").setup({
      scope = "line",
      modes = { "i", "ic", "ix", "R", "Rc", "Rx", "Rv", "Rvc", "Rvx" },
      blending = {
        threshold = 0.75,
        colorcode = "#000000",
        hlgroup = {
          "Normal",
          "background",
        },
      },
      warning = {
        alpha = 0.4,
        offset = 0,
        colorcode = "#FF0000",
        hlgroup = {
          "Error",
          "background",
        },
      },
      extra = {
        follow_tw = nil,
      },
    })
  end,
}
