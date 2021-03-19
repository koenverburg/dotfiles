-- N . <filename> (N)
local fmt = string.format
local M = {}

function M.minimal()
  local line = ''
  local currentTab = vim.fn.tabpagenr()
  local tabs = vim.fn.tabpagenr('$')

  for index = 1, tabs do
    local window_number = vim.fn.tabpagewinnr(index)
    local buffer_list   = vim.fn.tabpagebuflist(index)
    local buffer_number = buffer_list[window_number]

    local name_normal = vim.fn.fnamemodify(vim.fn.bufname(buffer_number), ':t')
    local paneCount = buffer_list

    if index == currentTab then
      name = name_normal
      activeSign = '●'
    else
      name = name_normal
      activeSign = ' '
    end

    if #buffer_list > 1 then
      pane_count = fmt('(%s) ', #buffer_list)
    else
      pane_count = ''
    end

    tab = fmt('%s %s %s %s', index, activeSign, name, pane_count)

    line = line .. tab
  end

  vim.o.tabline = line
end

vim.cmd([[autocmd BufWinEnter,WinEnter * silent! lua require'plugins.tabline'.minimal()]])

return setmetatable({}, {
  __index = function(_, k)

    if M[k] then
      return M[k]
    else
      return require('telescope.builtin')[k]
    end
  end
})


