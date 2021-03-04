local map_tele = function(key, f, options)
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

  vim.api.nvim_set_keymap(mode, key, rhs, options)
end

map_tele('<space>fa', 'buffers')
map_tele('<space>gcw', 'grep_current_word')

map_tele('<space>gb', 'git_branches')

map_tele('<space>ft', 'find_files')
map_tele('<space>t' , 'git_files')
map_tele('<space>ff', 'grep_string')

-- lsp
map_tele('<space>gr', 'lsp_references')
map_tele('<space>gs', 'lsp_document_syms')
map_tele('<space>ca', 'lsp_code_actions')

return map_tele
