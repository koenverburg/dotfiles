require("fidget").setup()
require("nvim-tree").setup()
require("session-lens").setup()
require("minimal-tabline").setup()
require("dim").setup()

require("Comment").setup() -- The bindings need to updated from this plugin

require("nvim-autopairs").setup()
local Rule = require "nvim-autopairs.rule"
local npairs = require "nvim-autopairs"
npairs.add_rule(Rule("<", ">"))
