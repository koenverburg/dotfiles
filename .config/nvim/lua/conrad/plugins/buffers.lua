-- local ui = vim.api.nvim_list_uis()[1]
require 'jabs'.setup({
  position = 'center', -- center, corner
  width = 50,
  height = 10,
  border = 'single', -- none, single, double, rounded, solid, shadow, (or an array or chars)
})

  -- -- Options for preview window
  -- preview_position = 'left', -- top, bottom, left, right
  -- preview = {
  --   width = 40,
  --   height = 30,
  --   border = 'double', -- none, single, double, rounded, solid, shadow, (or an array or chars)
  -- },

  -- the options below are ignored when position = 'center'
  -- col = ui.width,  -- Window appears on the right
  -- row = ui.height/2, -- Window appears in the vertical middle
