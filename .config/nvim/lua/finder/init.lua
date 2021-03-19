local themes = require('telescope.themes')
local sorters = require('telescope.sorters')

require 'telescope'.setup {
  defaults = {
    file_sorter = require('telescope.sorters').get_fzy_sorter,
    color_devicons = true,

    borderchars = {"─", "│", "─", "│", "┌", "┐", "┘", "└"},
  },
  extensions = {
    fzy_native = {
      override_file_sorter = true,
      override_generic_sorter = true,
    },
    fzf_writer = {
      minimum_grep_characters = 2,
      minimum_files_characters = 2,

      -- Disabled by default.
      -- Will probably slow down some aspects of the sorter, but can make color highlights.
      -- I will work on this more later.
      use_highlighter = true,
    }
  }
}

require('telescope').load_extension('fzy_native')

local M = {}

function M.lsp_references()
  local opts = themes.get_dropdown { }
  require('telescope.builtin').lsp_references(opts)
end


function M.find_files_dotfiles()
  local opts = {
    prompt_title = "~ Dotfiles ~",
    shorten_path = false,
    cwd = "~/code/github/dotfiles",
    prompt_position = 'bottom',
    scroll_strategy = 'cycle',
    sorting_strategy = 'descending',
  }

  require('telescope.builtin').git_files(opts)
end

function M.live_grep_custom()
  local opts = {
    shorten_path = false,
    prompt_position = 'bottom',
    scroll_strategy = 'cycle',
    sorting_strategy = 'descending',
  }

  require('telescope.builtin').live_grep(opts)
end


function M.find_files()
  local opts = {
    winblend = 10,
    previewer = false,
    prompt_position = 'bottom',
    scroll_strategy = 'cycle',
    sorting_strategy = 'descending',
  }

  require('telescope').extensions.fzf_writer.files(opts)
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

return setmetatable({}, {
  __index = function(_, k)

    if M[k] then
      return M[k]
    else
      return require('telescope.builtin')[k]
    end
  end
})
