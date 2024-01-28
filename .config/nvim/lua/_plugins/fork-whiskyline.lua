require("global")

local plugin = "fork-whiskyline"

return {
  dir = "~/code/github/whiskyline.nvim",
  -- "koenverburg/whiskyline.nvim",
  lazy = true,
  event = LoadOnBuffer,
  enabled = Is_enabled(plugin),
  config = function()
    require('whiskyline').setup()
  end,
}
