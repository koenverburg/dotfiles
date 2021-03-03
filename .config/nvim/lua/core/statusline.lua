vim.cmd [[packadd express_line.nvim]]

require('el').reset_windows()
local builtin = require('el.builtin')
local extensions = require('el.extensions')
local sections = require('el.sections')
local lsp_statusline = require('el.plugins.lsp_status')

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

      lsp_statusline.current_function,
      lsp_statusline.server_progress,

      '[', builtin.line_with_width(3), ':',  builtin.column_with_width(2), ']',

      sections.collapse_builtin {
        '[',
          builtin.help_list,
          builtin.readonly_list,
        ']',
      },
      builtin.filetype,
    }
  end
}

