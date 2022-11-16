local easypick = require "easypick"
local pick = {}

pick.setup = function()
  easypick.setup {
    pickers = {
      {
        name = "changed_files_api",
        command = "git diff master --name-only",
        previewer = easypick.previewers.branch_diff { base_branch = "master" },
      },

      {
        name = "changed_files_exp",
        command = "git diff main --name-only",
        previewer = easypick.previewers.branch_diff { base_branch = "main" },
      },
    },
  }
end

return pick
