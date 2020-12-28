local themes = require('telescope.themes')
local sorters = require('telescope.sorters')

require 'telescope'.setup {
  defaults = {
    winblend = 0,
    border = true,
    preview_cutoff = 120,

    prompt_position = 'top',
    scroll_strategy = 'cycle',
    layout_strategy = 'horizontal',
    sorting_strategy = 'ascending',
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

function M.lsp_code_actions()
  local opts = themes.get_dropdown {
    previewer = false,
  }

  require('telescope.builtin').lsp_code_actions()
end


function M.lsp_document_syms()
  local opts = themes.get_dropdown { }
  require('telescope.builtin').lsp_document_symbols(opts)
end

function M.lsp_references()
  local opts = themes.get_dropdown { }
  require('telescope.builtin').lsp_references(opts)
end

function M.fuzzy()
  local opts = {
    winblend = 10,
    prompt_position = 'bottom',
    scroll_strategy = 'cycle',
    sorting_strategy = 'descending',
  }

  require('telescope.builtin').find_files(opts)
end

function M.git_files()
  local opts = themes.get_dropdown {
    winblend = 0,
    previewer = false,
    shorten_path = false,
  }

  require('telescope.builtin').git_files(opts)
end

function M.buffers()
  -- TODO: when confirming a file make it that you jump to that buffer and not open it in the current buffer
  require('telescope.builtin').buffers {
    shorten_path = false,
    scroll_strategy = 'cycle',
  }
end

--function M.builtin()
  --require('telescope.builtin').builtin()
--end

return setmetatable({}, {
  __index = function(_, k)

    if M[k] then
      return M[k]
    else
      return require('telescope.builtin')[k]
    end
  end
})
