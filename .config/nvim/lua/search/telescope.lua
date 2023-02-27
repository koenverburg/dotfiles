local utils = require "utils"
local ts = require "telescope"
local themes = require "telescope.themes"
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

ts.setup {
  defaults = {
    color_devicons = true,
    borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
    sorting_strategy = "ascending",
    layout_config = {
      height = 0.75,
      width = 0.9,
    },
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
ts.load_extension "vim_bookmarks"
-- ts.load_extension "session-lens"

local M = {}

-- function M.session_lens()
--   local opts = {
--     previewer = false,
--   }
--   require("session-lens").search_session(opts)
-- end

function M.my_lsp_references()
  local opts = themes.get_dropdown()
  require("telescope.builtin").lsp_references(opts)
end

function M.my_lsp_document_symbols()
  local opts = themes.get_dropdown()
  require("telescope.builtin").lsp_document_symbols(opts)
end

function M.find_files_dotfiles()
  local opts = {
    prompt_title = "~ Dotfiles ~",
    cwd = "~/code/github/dotfiles",
    -- previewer = true,
    layout_strategy = "horizontal",
    layout_config = {
      prompt_position = "top",
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
      prompt_position = "top",
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
      prompt_position = "top",
    },
  }

  require("telescope.builtin").live_grep(opts)
end

function M.find_files()
  local opts = {
    layout_strategy = "horizontal",
    layout_config = {
      prompt_position = "top",
    },
    find_command = {
      "rg",
      "--ignore",
      "--hidden",
      "--files",
    },
  }

  require("telescope.builtin").find_files(opts)
end

-- M.telescope_theme = {
--   results_title = false,
--   layout_strategy = "center",
--   sorting_strategy = "ascending",
--   previewer = false,
--   prompt_prefix = "      ",
--   winblend = 30,
--   layout_config = { width = 0.6, height = 0.6 },
--   borderchars = {
--     preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
--     prompt = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
--     results = { "─", " ", " ", " ", "╰", "╯", " ", " " },
--   },
-- }

function M.git_files()
  local opts = {
    prompt_prefix = "",
    results_title = false,
    layout_config = {
      prompt_position = "top",
    },
    -- winblend = 85,
    -- borderchars = {
    --   -- defaults = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    --   preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    --   prompt = { " ", " ", " ", " ", " ", " ", " ", " " },
    --   results = { "─", " ", " ", " ", " ", " ", " ", " " },
    -- },
  }
  require("telescope.builtin").git_files(opts)
end

function M.ctrl_p()
  local opts = themes.get_dropdown {
    prompt_prefix = "",
    results_title = false,

    previewer = false,
    layout_strategy = "center",
    sorting_strategy = "ascending",
    layout_config = {
      width = 0.6,
      height = 0.6,
      prompt_position = "top",
    },

    -- borderchars = {
    --   -- defaults = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    --   preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    --   prompt = { " ", " ", " ", " ", " ", " ", " ", " " },
    --   results = { "─", " ", " ", " ", " ", " ", " ", " " },
    -- },
  }

  require("telescope.builtin").git_files(opts)
end

function M.spell_checker()
  local opts = themes.get_cursor {
    prompt_title = "",
    layout_config = {
      height = 0.25,
      width = 0.25,
    },
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

function M.custom_buffers()
  local opts = themes.get_dropdown {
    -- prompt_prefix = "",
    -- results_title = false,
    previewer = false,
    layout_strategy = "center",
    sorting_strategy = "ascending",
    layout_config = {
      width = 0.6,
      height = 0.6,
      prompt_position = "top",
    },
    -- borderchars = {
    --   -- defaults = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    --   preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    --   prompt = { " ", " ", " ", " ", " ", " ", " ", " " },
    --   results = { "─", " ", " ", " ", " ", " ", " ", " " },
    -- },
    attach_mappings = function(prompt_bufnr, map)
      local delete_buf = function()
        local selection = action_state.get_selected_entry()

        actions.close(prompt_bufnr)

        vim.api.nvim_buf_delete(selection.bufnr, { force = true })
      end

      map("i", "d", delete_buf)

      return true
    end,
  }

  require("telescope.builtin").buffers(opts)
end

function M.bookmarks()
  local opts = themes.get_dropdown {
    previewer = false,
    layout_strategy = "horizontal",
    layout_config = {
      prompt_position = "top",
    },
  }
  require("telescope").extensions.vim_bookmarks.all(opts)
end

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
