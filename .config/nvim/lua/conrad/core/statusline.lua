vim.cmd [[packadd express_line.nvim]]

require('el').reset_windows()
local builtin = require('el.builtin')
local sections = require('el.sections')
local extensions = require('el.extensions')

local get_lsp_client = function (msg)
  msg = msg or 'No lsp'

  local buffer_filetype = vim.api.nvim_buf_get_option(0, 'filetype')
  local clients = vim.lsp.get_active_clients()

  if next(clients) == nil then
    return msg
  end

  for _, client in ipairs(clients) do
    local filetypes = client.config.filetypes
    if filetypes and vim.fn.index(filetypes, buffer_filetype) ~= -1 then
      return client.name
    end
  end

  return msg
end

require('el').setup {
  generator = function(_, _)
    return {
      extensions.gen_mode {
        format_string = ' %s '
      },

      ' ',
      extensions.git_icon,
      ' ',
      extensions.git_branch,

      sections.split,

      sections.maximum_width(builtin.responsive_file(140, 90), 0.30),
        sections.collapse_builtin {
        ' ',
        builtin.modified_flag
      },

      sections.split,

      'LSP: ' .. get_lsp_client() .. ' ',

      builtin.filetype,

      ' ',

      sections.collapse_builtin {
        builtin.help_list,
        builtin.readonly_list,
      },

      builtin.line_with_width(3), ':',  builtin.column_with_width(2),
    }
  end
}


