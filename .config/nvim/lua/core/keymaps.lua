local ts_settings = require("logic.telescope-settings")
local funcs = require("logic.functions")
local normal = funcs.normal
local visual = funcs.visual
local insert = funcs.insert
local is_enabled = funcs.is_enabled

if is_enabled("telescope") then
  local themes = require("telescope.themes")
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")

  funcs.telescope_map("<space>ff", function()
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
  end)

  funcs.telescope_map("<space>t", function()
    local opts = {
      prompt_prefix = "",
      results_title = false,
      layout_config = ts_settings.wide('top').layout_config,
    }
    require("telescope.builtin").git_files(opts)
  end)

  local simple_git = function()
    local opts = themes.get_dropdown({
      prompt_prefix = "",
      results_title = false,

      previewer = false,
      layout_strategy = "center",
      sorting_strategy = "ascending",

      layout_config = ts_settings.small_dropdown('top').layout_config,
    })
    require("telescope.builtin").git_files(opts)
  end

  funcs.telescope_map("<space>p", simple_git)
  funcs.telescope_map("<c-p>", simple_git)

  funcs.telescope_map("<space><space>", function()
    local opts = themes.get_dropdown({
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
    })
    require("telescope.builtin").buffers(opts)
  end)

  funcs.telescope_map("<space>gs", function()
    local input = {
      prompt = "Grep String ",
      default = "",
    }

    local function string_grep_proxy(value)
      local opts = {
        search = value,
        layout_strategy = "horizontal",
        layout_config = ts_settings.wide('top').layout_config,
      }

      require("telescope.builtin").grep_string(opts)
    end

    funcs.inputOrUI(input, string_grep_proxy)
  end)

  -- blazing fast current word searching
  funcs.telescope_map("<space>cs", function()
    local cword = vim.fn.expand("<cword>")

    local opts = {
      search = cword,
      layout_strategy = "horizontal",
      layout_config = ts_settings.wide('top').layout_config,
    }

    require("telescope.builtin").grep_string(opts)
  end)

  funcs.telescope_map("<space>fg", function()
    local opts = {
      -- shorten_path = false,
      -- scroll_strategy = 'cycle',
      -- sorting_strategy = 'descending',
      layout_strategy = "horizontal",
      layout_config = ts_settings.wide('top').layout_config,
    }

    require("telescope.builtin").live_grep(opts)
  end)

  funcs.telescope_map("<space>sn", function()
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
  end)

  funcs.telescope_map("<space>ed", function()
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
  end)

  funcs.telescope_map("<space>fd", function()
    local opts = {
      prompt_prefix = "",
      results_title = false,
      previewer = false,
      layout_config = ts_settings.wide('top').layout_config,
    }
    require("telescope.builtin").diagnostics(opts)
  end)

  -- funcs.telescope_map("<leader><space>h", "help_tags")
end

if is_enabled("telescope") and is_enabled("lsp") then
  -- local themes = require "telescope.themes"

  funcs.telescope_map("<c-r>", function()
    local opts = {
      previewer = true,
      layout_config = ts_settings.wide('top').layout_config,
    }
    require("telescope.builtin").lsp_references(opts)
  end)

  -- funcs.telescope_map("gr", function()
  --   local opts = {}
  --   require("telescope.builtin").lsp_references(opts)
  -- end)

  funcs.telescope_map("<c-d>", function()
    local opts = {
      previewer = true,
      layout_config = ts_settings.wide('top').layout_config,
    }
    require("telescope.builtin").lsp_document_symbols(opts)
  end)

  funcs.telescope_map("<leader>cx", "lsp_code_actions")
end

-- if is_enabled("telescope") and is_enabled("lsp") and is_enabled("sg") then
--   normal("<space>ss", [[<cmd>lua require('sg.telescope').fuzzy_search_results()<CR>]])
-- end

if is_enabled("refactoring") then
  normal("<leader>rr", [[ <cmd>lua require('refactoring').select_refactor()<CR> ]])

  visual("<leader>rev", [[ <cmd>lua require('refactoring').refactor('Extract Variable')<CR> ]])
  visual("<leader>ref", [[ <cmd>lua require('refactoring').refactor('Extract Function')<CR> ]])

  normal("<leader>rv", [[ <cmd>lua require('refactoring').debug.print_var()<CR> ]])
  visual("<leader>rv", [[ <cmd>lua require('refactoring').debug.print_var()<CR> ]])

  normal("<leader>dl", [[ <cmd>lua require('refactoring').debug.printf({})<CR> ]])
  normal("<leader>cl", [[ <cmd>lua require('refactoring').debug.cleanup({})<CR> ]])
end

if is_enabled("tmux") then
  normal("<c-h>", "<CMD>lua require('Navigator').left()<CR>")
  normal("<c-k>", "<CMD>lua require('Navigator').up()<CR>")
  normal("<c-l>", "<CMD>lua require('Navigator').right()<CR>")
  normal("<c-j>", "<CMD>lua require('Navigator').down()<CR>")
  normal("<c-p>", "<CMD>lua require('Navigator').previous()<CR>")
end

-- Vim bindings
--
-- ----------------------------------------------------------------------------
normal("q", "NOP") -- turn of recording of macros
normal("G", "Gzz")

-- Swap : and ; to make colon commands easer to type
normal(";", ":")
normal(":", ";")

-- Quick folding
normal("<space>f", "za<cr>")

-- Rapid movement
normal("<s-a>", ":edit %:h<cr>")

-- Move whole lines, kudos @theprimeagen
visual("J", ":m '>+1<CR>gv=gv")
visual("K", ":m '<-2<CR>gv=gv")

-- Copy from cursor position to end of the line
normal("Y", "y$")

-- Concat lines below on current line
normal("J", "mzJ`z")

-- Undo until , .
insert(",", ",<c-g>u")
insert(".", ".<c-g>u")

-- This is so I can quickly quite out of vim without having to close all the buffers
normal("<leader>q", "<cmd>lua require('logic.functions').quite()<cr>")

-- Easier Moving between splits
if not is_enabled("tmux") then
  normal("<C-j>", "<C-W><C-J>")
  normal("<C-k>", "<C-W><C-K>")
  normal("<C-l>", "<C-W><C-L>")
  normal("<C-h>", "<C-W><C-H>")
end

-- Better jk
normal("j", "<Plug>(accelerated_jk_gj)")
normal("k", "<Plug>(accelerated_jk_gk)")

-- Faster moving from beginning to end of a line
normal("H", "^")
normal("L", "g_")

visual("H", "^")
visual("L", "g_")

-- Jumping from the beginning of a []{}() to the end
normal("<Tab>", "%")

-- Splits
normal("-", ":sp<cr>|<c-w>j")
normal("|", ":vsp<cr>|<c-w>l")
normal("<space>-", ":sp<cr>|<c-w>j|:Telescope git_files<cr>")
normal("<space>|", ":vsp<cr>|<c-w>l|:Telescope git_files<cr>")

-- Keep search matches in the middle of the window
normal("n", "nzzzv")
normal("N", "Nzzzv")

-- Quickly return to normal mode
insert("jk", "<esc>")
insert("jj", "<esc>")
insert("kk", "<esc>")

-- keep text selected after indentation
visual("<", "<gv")
visual(">", ">gv")

-- quickly cancel search highlighting
normal("<leader><space>", ":nohl<cr>")

-- Faster saving
-- normal('<leader>w', ':w<cr>')
-- insert('<leader>w', ':w<cr>')

-- Creating a new tab
normal("<leader>t", ":tabnew<cr>|:Telescope git_files<cr>")

-- Tab movement
normal("<S-Tab>", ":tabnext<cr>")

normal("<space>", "za")

-- Credo, sort aliases in alphabetical order
visual("<leader>s", ":'<,'>!sort -f<cr>")

-- open folds faster, za toggles folds that are created
normal("of", "za")

-- ----------------------------------------------------------------------------
--
-- Plugins bindings
--
-- ----------------------------------------------------------------------------

-- Peepsight
normal("<space>c", "<cmd>lua require('peepsight').enable_center()<cr>")
normal("<space>C", "<cmd>lua require('peepsight').toggle()<cr>")

-- Formatting
normal("ga", "<Plug>(EasyAlign)")
visual("ga", "<Plug>(EasyAlign)")

-- Bookmark
-- normal('bt', [[ <cmd>BookmarkToggle<cr> ]])

-- Searching
normal("<leader>S", [[ <cmd>lua require('spectre').open()<cr> ]])
normal("<leader>sw", [[ <cmd>lua require('spectre').open_visual({ select_word=true })<cr> ]])
visual("<leader>s", [[ <esc>:lua require('spectre').open_visual()<cr> ]])
normal("<leader>sp", [[ viw:lua require('spectre').open_file_search()<cr> ]])

-- sessions
-- normal("<leader>ss", ":SSave<cr>")
-- normal("<leader>sc", ":SClose<cr>")

-- -- Focus mode
-- normal("<leader><space>f", ":ZenMode<cr>")
-- normal("<leader><space>ll", ":Twilight<cr>")

-- Commenting
-- normal("<space>C", [[ <cmd>lua require('nvim-comment-frame').add_multiline_comment()<cr> ]])
-- normal(',fa', '<cmd>ComAnnotation<cr>')
-- visual("<space>c", "<cmd>Commentary<cr>")

-- word hopping
-- normal("<leader>jf", ":HopWordMW<cr>")

-- Toggle Alternate
normal("<leader>ta", "<cmd>lua require('nvim-toggler').toggle()<cr>")

-- Focus
-- normal("<leader>z", [[ <cmd>lua require'centerpad'.toggle { leftpad = 36, rightpad = 36 }<cr> ]])

-- Harpoon
-- normal("<c-m>", '<cmd>lua require("harpoon.mark").add_file()<cr>')
-- normal("<c-f>", '<cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>')
-- normal("<c-a>", '<cmd>lua require("harpoon.ui").nav_file(1)<cr>')

-- Terminal
normal("<leader>gt", [[ <cmd>lua require('logic.functions').createTerminal("lazygit")<cr> ]])

-- ----------------------------------------------------------------------------
--
-- My plugins bindings
--
-- ----------------------------------------------------------------------------
normal("<space>ta", "<cmd>lua require('experiments.edit-alt').edit()<cr>")

-- normal("<space>/", "<cmd>lua require('logic.functions').PopUpSearch()<cr>")
-- normal('<Leader>T', [[ <cmd>lua require'lsp_extensions'.inlay_hints()<cr> ]])

-- Command Palette
normal("<space>cp", "<cmd>CmdPalette<cr>")

-- Find 'n Replace
-- normal("<leader>fr", ":%s/")


-- visual("<leader>fr", "'>s/")
-- visual("<space>fr", "'>s/")

normal("<leader><leader>x", "<cmd>lua require'logic.functions'.save_and_execute()<cr>")


-- vim.cmd [[ autocmd WinEnter,WinLeave,BufWinEnter * :lua require'logic.functions'.hideTablineWhenSingleTab() ]]
