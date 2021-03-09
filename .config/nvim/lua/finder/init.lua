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
      override_generic_sorter = true,
      override_file_sorter = true,
    }
  }
}

require('telescope').load_extension('fzy_native')

local M = {}

-- port to lsp saga
--function M.lsp_code_actions()
  --local opts = themes.get_dropdown {
    --previewer = false,
  --}

  --require('telescope.builtin').lsp_code_actions()
--end


--function M.lsp_document_syms()
  --local opts = themes.get_dropdown { }
  --require('telescope.builtin').lsp_document_symbols(opts)
--end

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

return setmetatable({}, {
  __index = function(_, k)

    if M[k] then
      return M[k]
    else
      return require('telescope.builtin')[k]
    end
  end
})
