local utils = require('utils')

local neogit = utils.loadable('neogit')
if not neogit then return end

neogit.setup({
  integrations = {
    diffview = true
  },
})
