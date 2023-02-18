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
  local bufferlist = require "ide.components.bufferlist"
  local callhierarchy = require "ide.components.callhierarchy"
  -- local explorer = require "ide.components.explorer"
  -- local branches = require "ide.components.branches"
  -- local bookmarks = require "ide.components.bookmarks"
  -- local terminal = require "ide.components.terminal"
  -- local terminalbrowser = require "ide.components.terminal.terminalbrowser"

  module.setup {
    -- The global icon set to use.
    -- values: "nerd", "codicon", "default"
    icon_set = "nerd",
    -- Set the log level for nvim-ide's log. Log can be accessed with
    -- 'Workspace OpenLog'. Values are 'debug', 'warn', 'info', 'error'
    log_level = "info",
    -- Component specific configurations and default config overrides.
    components = {
      BufferList = {
          default_height = 10,
      },
      --
      -- If a more specific keymap override is defined for a specific Component
      -- this takes precedence.
      global_keymaps = {
        -- example, change all Component's hide keymap to "h"
        -- hide = h
      },

      -- example, prefer "x" for hide only for Explorer component.
      -- Explorer = {
      --     keymaps = {
      --         hide = "x",
      --     }
      -- }
    },
    -- default panel groups to display on left and right.
    panels = {
      left = 'none',
      right = "explorer",
    },
    -- panels defined by groups of components, user is free to redefine the defaults
    -- and/or add additional.
    panel_groups = {
      none = {
        -- callhierarchy.Name,
        -- bookmarks.Name,
      },

      explorer = {
        outline.Name,
        bufferlist.Name,
        -- explorer.Name,
        -- terminalbrowser.Name,
      },

      -- terminal = { terminal.Name },
      git = { changes.Name, commits.Name, timeline.Name },
    },
    -- workspaces config
    workspaces = {
      -- which panels to open by default, one of: 'left', 'right', 'both', 'none'
      auto_open = "none",
    },
    -- default panel sizes for the different positions
    panel_sizes = {
      left = 30,
      right = 30,
      bottom = 15,
    },
  }
end


return ide
