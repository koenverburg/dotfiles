-- N . <filename> (N)

local c = require('colorbuddy.color').colors
local s = require('colorbuddy.style').styles
local Group = require('colorbuddy.group').Group

local fn = vim.fn
local fmt = string.format

local options = {
  enable_tab_index = false,
  enable_pane_count = false,
  enable_modified_sign = true,
  no_name = '[No Name]'
}

local function minimal()
  local line = ''
  local current_tab = fn.tabpagenr()

  for index = 1, fn.tabpagenr('$') do
    local winnumber = fn.tabpagewinnr(index)
    local buffer_list = fn.tabpagebuflist(index)
    local buffnumber = buffer_list[winnumber]
    local buffer_name = fn.bufname(buffnumber)
    local buffer_modified = fn.getbufvar(buffnumber, '&mod')

    line = line .. '%' .. index .. 'T'

    -- TODO added hi when active
    if options.enable_tab_index then
        line = line .. index .. ' '
    else
        line = line .. ' '
    end

    local modified_sign = '%#ConradReset#' .. ' '

    -- TODO added hi when active
    if options.enable_modified_sign and buffer_modified == 1 then
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

    if options.enable_pane_count and #buffer_list > 1 then
      line = line .. fmt('(%s) ', #buffer_list)
    end

  end

  line = line .. '%#TabLineFill#'
  return line
end

Group.new('TabLineFill', c.cyan:dark(), nil, s.NONE)
Group.new('ConradActiveTabline', c.white:dark(), nil, s.bold + s.underline)
Group.new('ConradInActiveTabline', c.white:dark(), nil, s.NONE)
Group.new('ConradReset', nil, nil, nil)

Group.new('VertSplit', nil, nil, nil)

function _G.tabline()
  return minimal()
end


vim.o.showtabline = 2
vim.o.tabline = '%!v:lua.tabline()'
