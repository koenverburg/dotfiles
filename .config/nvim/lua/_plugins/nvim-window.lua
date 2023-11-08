local is_enabled = require("logic.functions").is_enabled
local normal = require("logic.functions").normal

local plugin = "nvim-window"

if is_enabled(plugin) then
  normal("<leader>w", "<cmd>lua require('nvim-window').pick()<cr>")
end

return {
  "yorickpeterse/" .. plugin,
  enabled = is_enabled(plugin),
  lazy = false,
  opts = function()
    vim.cmd [[ hi BlackOnLightYellow guifg=#000000 guibg=#FFCC00 ]]

    require("nvim-window").setup({
      -- The characters available for hinting windows.
      chars = {
        'a',
        's',
        'd',
        'f',
        'g',
        'h',
        'j',
        'k',
        'l'
        -- "a",
        -- "b",
        -- "c",
        -- "d",
        -- "e",
        -- "f",
        -- "g",
        -- "h",
        -- "i",
        -- "j",
        -- "k",
        -- "l",
        -- "m",
        -- "n",
        -- "o",
        -- "p",
        -- "q",
        -- "r",
        -- "s",
        -- "t",
        -- "u",
        -- "v",
        -- "w",
        -- "x",
        -- "y",
        -- "z",
      },

      -- A group to use for overwriting the Normal highlight group in the floating
      -- window. This can be used to change the background color.
      -- normal_hl = "Normal",
      -- -- The highlight group to apply to the line that contains the hint characters.
      -- -- This is used to make them stand out more.
      -- hint_hl = "Bold",
      -- -- The border style to use for the floating window.
      -- border = "single",

      normal_hl = 'BlackOnLightYellow',
      hint_hl = 'Bold',
      border = 'none'
    })
  end,
}
