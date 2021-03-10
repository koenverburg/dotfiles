-- N . <filename> (N)
local tab = {}

function tab.minimal()
  local line = ''
  local currentTab = vim.fn.tabpagenr()
  local tabs = vim.fn.tabpagenr('$')

  for index = 1, tabs do
    local window_number = vim.fn.tabpagewinnr(index)
    local buffer_list   = vim.fn.tabpagebuflist(index)
    local buffer_number = buffer_list[window_number]

    local name = vim.fn.fnamemodify(vim.fn.bufname(buffer_number), ':t')
    local paneCount = buffer_list

    if index == currentTab then
      activeSign = ' ●'
    else
      activeSign = ''
    end

    tab = index .. activeSign ..  ' '  .. name .. ' ' -- .. ' (' ..  #buffer_list .. ') '
    line = line .. tab
  end

  print('trigger' .. currentTab)
  return line
end

vim.o.tabline = tab.minimal()

--vim.cmd [=[augroup TabLineAutoSetup]=]
--vim.cmd [=[ au!]=]
--vim.cmd [=[ autocmd BufWinEnter,WinEnter * <cmd>lua vim.o.tabline = :lua require("plugins.tabline").minimal() ]=]
--vim.cmd [=[augroup END]=]
--vim.cmd [[doautocmd BufWinEnter]]

--require('plenary.reload').reload_module('tabline', true)
--require('plugins.tabline').minimal()

--return setmetatable({}, {
  --__index = function(_, k)

    --if tab[k] then
      --return tab[k]
    --else
      --return require('plugins.tabline')[k]
    --end
  --end
--})
