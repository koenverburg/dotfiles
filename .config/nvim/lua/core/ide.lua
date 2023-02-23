local ide = {}

ide.setup = function()
  local ok, module = pcall(require, "ide")

  if not ok then
    return
  end

  local changes = require "ide.components.changes"
  local commits = require "ide.components.commits"
  local outline = require "ide.components.outline"
  local timeline = require "ide.components.timeline"
  local terminal = require "ide.components.terminal"
  local bufferlist = require "ide.components.bufferlist"
  local callhierarchy = require "ide.components.callhierarchy"
  -- local bookmarks = require "ide.components.bookmarks"
  -- local explorer = require "ide.components.explorer"
  -- local branches = require "ide.components.branches"
  -- local terminalbrowser = require "ide.components.terminal.terminalbrowser"

  module.setup {
    icon_set = "nerd",
    log_level = "info",
    components = {
      -- BufferList = {
      --   default_height = 10,
      -- },
    },
    panels = {
      left = "empty",
      right = "explorer",
    },
    panel_groups = {
      empty = {},

      lhs = {
        callhierarchy.Name,
        -- bookmarks.Name,
      },

      explorer = {
        outline.Name,
        bufferlist.Name,
        -- explorer.Name,
        -- terminalbrowser.Name,
      },

      terminal = { terminal.Name },
      git = { changes.Name, commits.Name, timeline.Name },
    },
    workspaces = {
      auto_open = "none" -- one of: 'left', 'right', 'both', 'none'
    },
    panel_sizes = {
      left = 30,
      right = 30,
      bottom = 15,
    },
  }
end


return ide
