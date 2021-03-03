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

function M.find_files()
  local opts = {
    winblend = 10,
    prompt_position = 'bottom',
    scroll_strategy = 'cycle',
    sorting_strategy = 'descending',
  }

  require('telescope.builtin').find_files(opts)
end

function M.grep_string()
  local opts = themes.get_dropdown {
    winblend = 0,
    shorten_path = false,
  }

  require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})
end

function M.grep_current_word()
  local opts = themes.get_dropdown {
    winblend = 0,
    shorten_path = false,
  }

  require('telescope.builtin').grep_string({ search = vim.fn.expand("<cword>") })
end

function M.buffers()
  -- TODO: when confirming a file make it that you jump to that buffer and not open it in the current buffer
  require('telescope.builtin').buffers {
    shorten_path = false,
    scroll_strategy = 'cycle',
  }
end

function M.git_files()
  local opts = {
    winblend = 0,
    shorten_path = false,
  }

  require('telescope.builtin').git_files(opts)
end

function M.git_branches() 
    require("telescope.builtin").git_branches({
        attach_mappings = function(prompt_bufnr, map) 
            map('i', '<c-d>', actions.git_delete_branch)
            map('n', '<c-d>', actions.git_delete_branch)
            return true
        end
    })
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
