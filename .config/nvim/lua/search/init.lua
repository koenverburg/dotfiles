local pick = require('search.easypick')

pick.setup()

local telescope_map = function(key, f, options, buffer)
  local mode = "n"

  options = options or {
    silent = true,
    noremap = true,
  }

  local rhs = string.format(
    "<cmd>lua require('search.telescope')['%s'](%s)<CR>",
    f,
    options and vim.inspect(options, { newline = "" }) or ""
  )

  if not buffer then
    vim.api.nvim_set_keymap(mode, key, rhs, options)
  else
    vim.api.nvim_buf_set_keymap(0, mode, key, rhs, options)
  end
end

-- ----------------------------------------------------------------------------
--
-- Telescope
--
-- ----------------------------------------------------------------------------
-- Find in other projects
telescope_map("<space>sn", "find_files_notes")
telescope_map("<space>ed", "find_files_dotfiles")

telescope_map("<space>gw", "get_worktrees")
telescope_map("<space>cwt", "create_worktree")

telescope_map("<leader><space>h", "help_tags")

telescope_map("<space>t", "git_files")
telescope_map("<space>ff", "find_files")
telescope_map('<space>p', 'ctrl_p')
-- telescope_map("<space><space>", "buffers")

telescope_map("<space>gw", "git_worktrees")


-- Search for a work
telescope_map("<space>sg", "my_string_grep")
telescope_map("<space>fg", "my_live_grep")
telescope_map("<space>ls", "session_lens")

-- spell checker
telescope_map("<leader>sc", "spell_checker")

-- File browser
telescope_map("<space>fb", "browser") -- ivy

-- lsp
telescope_map("<c-r>", "my_lsp_references") -- ivy
telescope_map("<c-d>", "my_lsp_document_symbols") -- ivy
telescope_map("<leader>cx", "lsp_code_actions")

telescope_map("<leader>re", "refactors")
