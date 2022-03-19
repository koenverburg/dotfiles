local helper = require "el.helper"
local subscribe = require "el.subscribe"
local extensions = require "el.extensions"
local builtin = require "el.builtin"
local sections = require "el.sections"
local lsp_statusline = require "el.plugins.lsp_status"
local diagnostic = require "el.diagnostic"
local has_lsp_extensions, ws_diagnostics = pcall(require, "lsp_extensions.workspace.diagnostic")
local P = function(v)
  print(vim.inspect(v))
end

local git_branch = subscribe.buf_autocmd("el_git_branch", "BufEnter", function(window, buffer)
  local branch = extensions.git_branch(window, buffer)
  if branch then
    return " " .. extensions.git_icon() .. " " .. branch
  end
end)

local show_current_func = function(window, buffer)
  if buffer.filetype == "lua" then
    return ""
  end

  return lsp_statusline.current_function(window, buffer)
end

local diagnostic_display = diagnostic.make_buffer()

local generator = function(win_id, buffer)
  local segments = {}

  table.insert(segments, " ")

  table.insert(segments, extensions.mode)

  table.insert(segments, git_branch)
  table.insert(segments, " ")

  table.insert(segments, builtin.file_relative)
  table.insert(segments, builtin.modified)

  table.insert(segments, " ")

  table.insert(
    segments,
    subscribe.buf_autocmd("el_file_icon", "BufRead", function(_, buffer)
      return extensions.file_icon(_, buffer)
    end)
  )


  table.insert(segments, sections.split)
  table.insert(segments, lsp_statusline.server_progress)
  table.insert(segments, diagnostic_display)

  table.insert(segments, sections.collapse_builtin(builtin.help_list, builtin.readonly_list))
  table.insert(segments, builtin.filetype)

  table.insert(
    segments,
    subscribe.buf_autocmd("el_git_status", "BufWritePost", function(window, buffer)
      local changes = extensions.git_changes(window, buffer)
      if changes then
        return " " .. changes
      end
    end)
  )


  -- table.insert(segments, git_branch)

  -- Option 5, there are several helper functions provided to asynchronously
  --  run timers which update buffer or window variables at a certain frequency.
  --
  --  These can be used to set infrequrently updated values without waiting.

  return segments
end

-- And then when you're all done, just call
require("el").setup { generator = generator }
