local M = {}

function M.save_and_execute()
  local filetype = vim.bo.filetype

  if filetype == 'vim' then
    vim.cmd [[silent! write]]
    vim.cmd [[source %]]
  elseif filetype == 'lua' then
    vim.cmd [[silent! write]]
    vim.cmd [[luafile %]]
  end
end

return setmetatable({}, {
  __index = function(_, k)

    if M[k] then
      return M[k]
    else
      return require('utils')[k]
    end
  end
})
