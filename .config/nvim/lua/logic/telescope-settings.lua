local config = require('core.config')
local M = {}

M.default = {
  color_devicons = true,
  sorting_strategy = "ascending",
  selection_caret = config.signs.caret .. " ",
  prompt_prefix = " " .. config.signs.telescope .. " ",
  layout_config = {
    height = 0.75,
    width = 0.9,
  },
  -- borderchars = {
  --   -- defaults = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
  --   preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
  --   prompt = { " ", " ", " ", " ", " ", " ", " ", " " },
  --   results = { "─", " ", " ", " ", " ", " ", " ", " " },
  -- },
  borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" }
}

function M.wide(position)
  return {
    layout_config = {
      prompt_position = position,
      height = function(_, _, max_lines)
        return math.floor(max_lines * 0.95)
      end,
      width = function(_, _, max_columns)
        local ww = vim.fn.winwidth('%')
        if ww < max_columns then
          return max_columns
        else
          return ww - 10
        end
      end
    }
  }
end

function M.wide_lsp(position)
  return {
    layout_config = {
      prompt_position = position,
      height = function(_, _, max_lines)
        return math.floor(max_lines * 0.95)
      end,
      width = function(_, _, max_columns)
        local ww = vim.fn.winwidth('%')
        if ww < max_columns then
          return max_columns
        else
          return ww - 10
        end
      end
    },
  }
end

function M.small_dropdown(position)
  return {
    layout_config = {
      width = 0.6,
      height = 0.6,
      prompt_position = position,
    },
  }
end

return M
