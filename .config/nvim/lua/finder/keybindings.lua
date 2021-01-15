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

map_tele('<space>fa', 'buffers')
map_tele('<space>fe', 'git_files')
map_tele('<space>ap', 'fuzzy')
map_tele('<space>gr', 'lsp_references')
map_tele('<space>gs', 'lsp_document_syms')
map_tele('<space>gg', 'grep')
--map_tele('<space>cx', 'lsp_code_actions')

return map_tele
