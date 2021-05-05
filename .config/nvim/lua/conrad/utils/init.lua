local M = {}

function M.bind(mode, key, func)
  vim.api.nvim_set_keymap(mode, key, func, {noremap = true, silent = true})
end

function M.normal(key, func)
  M.bind('n', key, func)
end

function M.visual(key, func)
  M.bind('v', key, func)
end

function M.insert(key, func)
  M.bind('i', key, func)
end

function M.terminal(key, func)
  M.bind('t', key, func)
end

return setmetatable({}, {
  __index = function(_, k)

    if M[k] then
      return M[k]
    else
      return require('conrad.utils')[k]
    end
  end
})
