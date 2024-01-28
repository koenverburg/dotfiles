require("global")

local plugin = "deadcolumn.nvim"

return {
  "Bekaboo/" .. plugin,
  enabled = Is_enabled(plugin),
  event = LoadOnBuffer,
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
