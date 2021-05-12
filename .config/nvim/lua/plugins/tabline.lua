-- N . <filename> (N)
local fn = vim.fn
local fmt = string.format

local function minimal()
  local options = {
    show_index = true,
    no_name = '[No Name]'
  }
  local line = ''
  for index = 1, fn.tabpagenr('$') do
    local winnumber = fn.tabpagewinnr(index)
    local buffer_list = fn.tabpagebuflist(index)
    local buffnumber = buffer_list[winnumber]
    local buffer_name = fn.bufname(buffnumber)
    local buffer_modified = fn.getbufvar(buffnumber, "&mod")

    line = line .. '%' .. index .. 'T'
    if index == fn.tabpagenr() then
        line = line
    else
        line = line
    end

    line = line .. ' '
    if options.show_index then
        line = line .. index .. ':'
    end

    if #buffer_list > 1 then
      line = line .. fmt('(%s) ', #buffer_list)
    end

    if buffer_name ~= '' then
        line = line .. fn.fnamemodify(buffer_name, ':t') .. '  '
      else
        line = line .. options.no_name .. ' '
    end

    if buffer_modified == 1 then
        line = line .. '● '
    end
  end

  line = line -- .. '%#TabLineFill#'
  return line
end

function _G.tabline()
  return minimal()
end


vim.o.showtabline = 2
vim.o.tabline = '%!v:lua.tabline()'
