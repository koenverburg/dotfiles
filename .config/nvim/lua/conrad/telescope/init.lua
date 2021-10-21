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
      fuzzy = false,                    -- false will only do exact matching
      override_file_sorter = true,     -- override the file sorter
      override_generic_sorter = true, -- override the generic sorter
      case_mode = 'ignore_case',        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    },
    frecency = {
      -- db_root = "home/my_username/path/to/db_root",
      -- show_scores = false,
      -- show_unindexed = true,
      -- ignore_patterns = {"*.git/*", "*/tmp/*"},
      -- disable_devicons = false,
      workspaces = {
        ["glass"]    = "~/code/bitbucket/glass",
        ["checkout"]    = "~/code/bitbucket/checkout",
        ["dotfiles"]    = "~/code/github/dotfiles",
        -- ["diva"]    = "~/code/github/dotfiles",
      }
    }
  }
}

require('git-worktree').setup()
-- change_directory_command = <str> -- default: "cd",
-- update_on_change = <boolean> -- default: true,
-- update_on_change_command = <str> -- default: "e .",
-- clearjumps_on_change = <boolean> -- default: true,
-- autopush = <boolean> -- default: false,

require('telescope').load_extension('fzf')
require('telescope').load_extension('frecency')
require('telescope').load_extension('git_worktree')
require('telescope').load_extension('session-lens')

local M = {}

function M.session_lens()
  local opts = {
    previewer = false
  }
  require('session-lens').search_session(opts)
end

function M.my_lsp_references()
  local opts = {
    layout_strategy= 'vertical',
    layout_config = {
      prompt_position = 'bottom',
    }
  }
  require('telescope.builtin').lsp_references(opts)
end

function M.my_lsp_document_symbols()
  local opts = {
    layout_strategy= 'vertical',
    layout_config = {
      prompt_position = 'bottom',
    }
  }
  require('telescope.builtin').lsp_document_symbols(opts)
end

function M.find_files_dotfiles()
  local opts = {
    prompt_title = '~ Dotfiles ~',
    cwd = '~/code/github/dotfiles',
    -- previewer = true,
    layout_strategy= 'horizontal',
    layout_config = {
      prompt_position = 'bottom',
    }
  }

  require('telescope.builtin').git_files(opts)
end


function M.my_string_grep()
  local query = vim.fn.input('Search for > ')

  local opts = {
    search = query,
    layout_strategy= 'horizontal',
    layout_config = {
      prompt_position = 'bottom',
    }
  }

  require('telescope.builtin').grep_string(opts)
end

function M.my_live_grep()
  local opts = {
    -- shorten_path = false,
    -- scroll_strategy = 'cycle',
    -- sorting_strategy = 'descending',
    layout_strategy= 'horizontal',
    layout_config = {
      prompt_position = 'bottom',
    }
  }

  require('telescope.builtin').live_grep(opts)
end

function M.find_files()
  local opts = {
    layout_strategy= 'vertical',
    layout_config = {
      prompt_position = 'bottom',
    }
  }

  require('telescope.builtin').find_files(opts)
end

function M.git_files()
  local opts = {
    previewer = false,
    layout_strategy= 'horizontal',
    layout_config = {
      prompt_position = 'bottom',
    }
  }

  require('telescope.builtin').git_files(opts)
end

function M.frecency_files()
  local opts = {
    previewer = false,
    layout_strategy= 'horizontal',
    layout_config = {
      prompt_position = 'bottom',
    }
  }

  require('telescope').extensions.frecency.frecency()
end

function M.git_worktrees()
  require('telescope').extensions.git_worktree.git_worktrees()
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

