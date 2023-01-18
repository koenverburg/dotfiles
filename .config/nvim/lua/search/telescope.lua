local utils = require("utils")
local ts = require('telescope')
local themes = require("telescope.themes")

ts.setup {
  defaults = {
    color_devicons = true,
    borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
    layout_config = {
      height = 0.75,
      width = 0.9
    }
  },
  extensions = {
    fzf = {
      fuzzy = false, -- false will only do exact matching
      override_file_sorter = true, -- override the file sorter
      override_generic_sorter = true, -- override the generic sorter
      case_mode = "ignore_case", -- or "ignore_case" or "respect_case", the default case_mode is "smart_case"
    },
    file_browser = {
      -- theme = "ivy",
    },
  },
}

require("git-worktree").setup()
-- change_directory_command = <str> -- default: "cd",
-- update_on_change = <boolean> -- default: true,
-- update_on_change_command = <str> -- default: "e .",
-- clearjumps_on_change = <boolean> -- default: true,
-- autopush = <boolean> -- default: false,

ts.load_extension "fzf"
ts.load_extension "git_worktree"
ts.load_extension "file_browser"
ts.load_extension "telescope-tabs"
ts.load_extension "find_template"
-- ts.load_extension "session-lens"

local M = {}

function M.session_lens()
  local opts = {
    previewer = false,
  }
  require("session-lens").search_session(opts)
end

function M.my_lsp_references()
  local opts = themes.get_ivy()
  require("telescope.builtin").lsp_references(opts)
end

function M.my_lsp_document_symbols()
  local opts = themes.get_ivy()
  require("telescope.builtin").lsp_document_symbols(opts)
end

function M.find_files_dotfiles()
  local opts = {
    prompt_title = "~ Dotfiles ~",
    cwd = "~/code/github/dotfiles",
    -- previewer = true,
    layout_strategy = "horizontal",
    layout_config = {
      prompt_position = "bottom",
    },
  }

  require("telescope.builtin").git_files(opts)
end

function M.find_files_notes()
  local opts = {
    previewer = false,
    prompt_title = "~ Notes ~",
    cwd = "~/code/github/obsidian",
    layout_strategy = "vertical",
    layout_config = {
      prompt_position = "bottom",
    },
  }

  require("telescope.builtin").git_files(opts)
end

function M.my_string_grep()
  local input = {
    prompt = "string grep",
    default = "",
  }

  local function string_grep_proxy(value)
    local opts = {
      search = value,
      layout_strategy = "horizontal",
      layout_config = {
        prompt_position = "top",
      },
    }

    require("telescope.builtin").grep_string(opts)
  end

  utils.inputOrUI(input, string_grep_proxy)
end

function M.my_live_grep()
  local opts = {
    -- shorten_path = false,
    -- scroll_strategy = 'cycle',
    -- sorting_strategy = 'descending',
    layout_strategy = "horizontal",
    layout_config = {
      prompt_position = "bottom",
    },
  }

  require("telescope.builtin").live_grep(opts)
end

function M.find_files()
  local opts = {
    layout_strategy = "horizontal",
    layout_config = {
      prompt_position = "bottom",
    },
    find_command = {
      'rg',
      '--ignore',
      '--hidden',
      '--files'
    }
  }

  require("telescope.builtin").find_files(opts)
end

function M.git_files()
  local opts = {}
  require("telescope.builtin").git_files(opts)
end

function M.ctrl_p()
  local opts = {
    previewer = false,
    layout_strategy = "horizontal",
    layout_config = {
      prompt_position = "bottom",
    },
  }

  require("telescope.builtin").git_files(opts)
end

function M.spell_checker()
  local opts = themes.get_cursor {
    prompt_title = "",
    layout_config = {
      height = 0.25,
      width = 0.25
    }
  }

  require("telescope.builtin").spell_suggest(opts)
end

-- function directory_exists(path)
--   local f = io.open(path, "r")
--   if f ~= nil then
--     io.close(f)
--     return true
--   else
--     return false
--   end
-- end
--
-- function M.main_search()
--   if directory_exists ".git" then
--     git_files()
--   else
--     find_files()
--   end
-- end

function M.git_worktrees()
  require("telescope").extensions.git_worktree.git_worktrees()
end

local function refactor(prompt_bufnr)
  local content = require("telescope.actions.state").get_selected_entry(prompt_bufnr)
  require("telescope.actions").close(prompt_bufnr)
  require("refactoring").refactor(content.value)
end

function M.browser()
  require("telescope").extensions.file_browser.file_browser()
end

function M.refactors()
  local opts = require("telescope.themes").get_cursor()
  -- bufnr = bufnr or vim.api.nvim_get_current_buf()

  require("telescope.pickers").new(opts, {
    prompt_title = "refactors",

    finder = require("telescope.finders").new_table {
      results = require("refactoring").get_refactors(),
    },

    sorter = require("telescope.config").values.generic_sorter(opts),
    attach_mappings = function(_, map)
      map("i", "<CR>", refactor)
      map("n", "<CR>", refactor)
      return true
    end,
  }):find()
end

return setmetatable({}, {
  __index = function(_, k)
    if M[k] then
      return M[k]
    else
      return require("telescope.builtin")[k]
    end
  end,
})