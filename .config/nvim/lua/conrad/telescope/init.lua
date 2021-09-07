local table = require('table')
local themes = require('telescope.themes')
local sorters = require('telescope.sorters')

require 'telescope'.setup {
  defaults = {
    color_devicons = true,

    borderchars = {"─", "│", "─", "│", "┌", "┐", "┘", "└"},
  },
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_file_sorter = true,     -- override the file sorter
      override_generic_sorter = false, -- override the generic sorter
      case_mode = 'smart_case',        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    }
  }
}

require('telescope').load_extension('fzf')
require('telescope').load_extension('frecency')
-- require('telescope').load_extension('mapper')
-- require('telescope').load_extension('snippets')

local M = {}

function M.lsp_references()
  local opts = themes.get_dropdown {
    previewer = false,
    prompt_position = 'top',
  }
  require('telescope.builtin').lsp_references(opts)
end


function M.find_files_dotfiles()
  local opts = {
    prompt_title = '~ Dotfiles ~',
    cwd = '~/code/github/dotfiles',
    previewer = true,
    layout_strategy= 'horizontal',
    layout_config = {
      prompt_position = 'top',
    }
  }

  require('telescope.builtin').git_files(opts)
end

function M.live_grep_custom()
  local opts = {
    shorten_path = false,
    scroll_strategy = 'cycle',
    sorting_strategy = 'descending',
  }

  require('telescope.builtin').live_grep(opts)
end


function M.find_files()
  local opts = {
    winblend = 10,
    previewer = false,
    -- prompt_position = 'bottom',
    scroll_strategy = 'cycle',
    sorting_strategy = 'descending',
  }

  require('telescope.builtin').find_files(opts)
end

function M.buffers()
  local opts = themes.get_dropdown {
    winblend = 0,
    previewer = false,
    shorten_path = false
  }
  require('telescope.builtin').buffers(opts)
end

function M.git_files()
  local opts = {
    winblend = 0,
    previewer = false,
    shorten_path = false
  }

  require('telescope.builtin').git_files(opts)
end

function M.get_frecency()
  local opts = {}

  require('telescope').extensions.frecency.frecency()
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

