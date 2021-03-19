local map_tele = function(key, f, options, buffer)
  local mode = "n"
  local rhs = string.format(
    "<cmd>lua require('finder')['%s'](%s)<CR>",
    f,
    options and vim.inspect(options, { newline = '' }) or ''
  )

  local options = {
    noremap = true,
    silent = true,
  }

  if not buffer then
    vim.api.nvim_set_keymap(mode, key, rhs, options)
  else
    vim.api.nvim_buf_set_keymap(0, mode, key, rhs, options)
  end
end

map_tele('<space>ff', 'find_files')
map_tele('<space>fg', 'live_grep_custom')
-- FIX Needs to focus on the file not open in the current buffer
--map_tele('<space>fb', 'buffers')

map_tele('<space>t' , 'git_files')
map_tele('<space>ed' , 'find_files_dotfiles')
--map_tele('<space>gb', 'git_branches')

-- lsp
map_tele('<leader>fr', 'lsp_references')
map_tele('<c-d>', 'lsp_document_symbols')

return map_tele
