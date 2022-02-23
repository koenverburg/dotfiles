local M = {}
local ls = require "luasnip"

-- Expand or Jump using <c-k>
M.ExpandOrJump = function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end

-- <c-j> is my jump backwards key.
-- this always moves to the previous item within the snippet
M.JumpBack = function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end

-- <c-l> is selecting within a list of options.
-- This is useful for choice nodes (introduced in the forthcoming episode 2)
M.ChangeChoice = function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end

return M
