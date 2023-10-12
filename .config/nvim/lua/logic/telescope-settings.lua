local config = require("core.config")
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
  borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
}

function M.wide(position)
  return {
    layout_config = {
      prompt_position = position,
      height = function(_, _, max_lines)
        return math.floor(max_lines * 0.95)
      end,
      width = function(_, _, max_columns)
        local ww = vim.fn.winwidth("%")

        print(ww, max_columns)
        local winnr = vim.fn.winnr("$")
        print(winnr)

        if winnr > 1 and winnr < 3 then
          return math.floor(ww * winnr * 0.95)
        elseif ww > max_columns then
          print('elseif')
          return math.floor(ww * winnr * 0.95)
        else
          return math.floor(max_columns * 0.95)
        end
      end,
    },
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
        local ww = vim.fn.winwidth("%")

        -- print(ww, max_columns)
        local winnr = vim.fn.winnr("$")
        -- print(winnr)

        if winnr > 1 and winnr < 3 then
          return math.floor(ww * winnr * 0.95)
        elseif ww < max_columns and winnr > 3 then
          return math.floor(ww * 3 * 0.95)
        else
          return math.floor(max_columns * 0.95)
        end
      end,
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
