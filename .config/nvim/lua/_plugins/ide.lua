local is_enabled = require("_apache.functions").is_enabled

return {
  'ldelossa/nvim-ide',
  lazy = false,
  enabled = is_enabled('ide'),
  config = function()
    -- default components
    local bufferlist = require("ide.components.bufferlist")
    local explorer = require("ide.components.explorer")
    local outline = require("ide.components.outline")
    local callhierarchy = require("ide.components.callhierarchy")
    local timeline = require("ide.components.timeline")
    local terminal = require("ide.components.terminal")
    local terminalbrowser = require("ide.components.terminal.terminalbrowser")
    local changes = require("ide.components.changes")
    local commits = require("ide.components.commits")
    local branches = require("ide.components.branches")
    local bookmarks = require("ide.components.bookmarks")

    require("ide").setup({
      -- The global icon set to use.
      -- values: "nerd", "codicon", "default"
      icon_set = "default",
      -- Set the log level for nvim-ide's log. Log can be accessed with
      -- 'Workspace OpenLog'. Values are 'debug', 'warn', 'info', 'error'
      log_level = "info",
      -- Component specific configurations and default config overrides.
      components = {
        -- The global keymap is applied to all Components before construction.
        -- It allows common keymaps such as "hide" to be overridden, without having
        -- to make an override entry for all Components.
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
        left = "explorer",
        right = "call",
      },
      -- panels defined by groups of components, user is free to redefine the defaults
      -- and/or add additional.
      panel_groups = {
        explorer = {
          outline.Name,
          -- bufferlist.Name,
          -- explorer.Name,
          -- bookmarks.Name,
          -- terminalbrowser.Name,
        },
        -- terminal = { terminal.Name },
        call = {
          callhierarchy.Name,
          -- changes.Name,
          -- commits.Name,
          -- timeline.Name,
          -- branches.Name
        },
      },
      -- workspaces config
      workspaces = {
        -- which panels to open by default, one of: 'left', 'right', 'both', 'none'
        auto_open = "both",
      },
      -- default panel sizes for the different positions
      panel_sizes = {
        left = 30,
        right = 30,
        bottom = 15,
      },
    })
  end,
}
