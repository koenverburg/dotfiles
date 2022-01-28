local M = {}

local c = require('colorbuddy.color').colors
local s = require('colorbuddy.style').styles
local Group = require('colorbuddy.group').Group

local fn = vim.fn
local fmt = string.format

local function minimal(options)
  local line = ''
  local current_tab = fn.tabpagenr()

  for index = 1, fn.tabpagenr('$') do
    local winnumber = fn.tabpagewinnr(index)
    local buffer_list = fn.tabpagebuflist(index)
    local buffnumber = buffer_list[winnumber]
    local buffer_name = fn.bufname(buffnumber)
    local buffer_modified = fn.getbufvar(buffnumber, '&mod')

    line = line .. '%' .. index .. 'T'

    if options.tab_index then
        line = line .. index .. ' '
    else
        line = line .. ' '
    end

    local modified_sign = '%#ConradReset#' .. ' '

    if options.modified_sign and buffer_modified == 1 then
        modified_sign = ' ●'
    end

    if buffer_name ~= '' then
        if index == current_tab then
          line = line .. '%#ConradActiveTabline#' .. fn.fnamemodify(buffer_name, ':t') .. modified_sign
        else
          line = line .. '%#ConradInActiveTabline#' .. fn.fnamemodify(buffer_name, ':t') .. modified_sign
        end
      else
        line = line .. options.no_name .. ' '
    end

    if options.pane_count and #buffer_list > 1 then
      line = line .. fmt('(%s) ', #buffer_list)
    end

  end

  line = line .. '%#TabLineFill#'
  return line
end

function M.setup(options)
  options = options or {}

  M.options = vim.tbl_deep_extend('force', {
    enable = true,
    tab_index = false,
    pane_count = false,
    modified_sign = true,
    no_name = '[No Name]'
  }, options)

  if M.options.tab_index == nil then
    M.options.tab_index = false
  end

  if M.options.pane_count == nil then
    M.options.pane_count = false
  end

  if M.options.modified_sign == nil then
    M.options.modified_sign = false
  end

  if M.options.no_name == nil then
    M.options.no_name = '[No Name]'
  end

  function _G.minimal_tabline()
    return minimal(M.options)
  end

  if M.options.enable then
    vim.o.showtabline = 2
    vim.o.tabline = '%!v:lua.minimal_tabline()'
  end
end

Group.new('TabLineFill', c.white:dark(), nil, s.NONE)
Group.new('ConradActiveTabline', c.white:dark(), nil, s.bold + s.underline)
Group.new('ConradInActiveTabline', c.white:dark(), nil, s.NONE)
Group.new('ConradReset', nil, nil, nil)
Group.new('VertSplit', nil, nil, nil)

return M
