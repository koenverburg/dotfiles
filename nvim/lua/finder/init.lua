local themes = require('telescope.themes')

require 'telescope'.setup {
  defaults = {
    winblend = 0,
    preview_cutoff = 120,

    prompt_position = "top",
    scroll_strategy = 'cycle',
    layout_strategy = 'horizontal',
    sorting_strategy = "ascending",
    color_devicons = true,

    layout_defaults = {
      horizontal = {
        width_padding = 0.1,
        height_padding = 0.1,
        preview_width = 0.6,
      },
      vertical = {
        width_padding = 0.05,
        height_padding = 1,
        preview_height = 0.5,
      }
    },

    borderchars = {"─", "│", "─", "│", "┌", "┐", "┘", "└"},
  }
}

local M = {}

function M.git_files()
  local opts = themes.get_dropdown {
    winblend = 10,
    border = true,
    previewer = false,
    shorten_path = false,
  }

  require('telescope.builtin').git_files(opts)
end

function M.buffers()
  require('telescope.builtin').buffers {
    shorten_path = false,
  }
end

function M.builtin()
  require('telescope.builtin').builtin()
end

return setmetatable({}, {
  __index = function(_, k)

    if M[k] then
      return M[k]
    else
      return require('telescope.builtin')[k]
    end
  end
})
