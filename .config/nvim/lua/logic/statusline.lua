local Job = require("plenary.job")
local core = require("core.config")

local utils = {}
local providers = {}
local builtins = {}

builtins.modified = "%m"
builtins.line = "%l"
builtins.number_of_lines = "%L"
builtins.split = "%="
builtins.space = " "
builtins.file_info = "%m%r%h%w%q"       -- flags: m:modified,r:RO,h:help,w:preview,q:quickfix list/loc list
builtins.ruler = "[%7(%l/%3L%):%2c %P]" -- ruler

function utils.isNil(val)
  if val == 0 or not val or val == "" or val == nil then
    return true
  end

  return false
end

function utils.dim(text)
  if text == "" then
    return
  end
  return "%#Comment#" .. text .. "%#Normal#"
end

function utils.get_icon_by_filetype(name)
  local ok, icons = pcall(require, "nvim-web-devicons")

  if not ok then
    return ""
  end

  local icon, color = icons.get_icon_by_filetype(name)
  if not icon then
    return ""
  end

  return "%#" .. color .. "#" .. icon .. "%#Normal#", color
end

providers.start = "%#Normal#"
function providers.git_branch()
  if not vim.b.gitsigns_status_dict then
    return " "
  end

  local branch = vim.b.gitsigns_status_dict["head"]
  branch = (not branch or branch == 0) and "" or tostring(branch)

  local icon, color = utils.get_icon_by_filetype("git")

  if not icon then
    return branch
  end

  return "%#Normal# " .. icon .. " " .. "%#" .. color .. "#" .. branch .. "%#Normal#"
end

function providers.git_changes()
  local chars = {
    added = "",
    files = "f",
    changed = "~",
    removed = "",
  }

  local colors = {
    added = "%#GitSignsAdd#",
    files = "%#GitSignsChange#",
    changed = "%#GitSignsChange#",
    removed = "%#GitSignsDelete#",
  }

  local result = {}
  Job:new({
    command = "git",
    args = { "diff", "--shortstat" },
    on_exit = function(j, _)
      result = j:result()
    end,
  }):sync() -- or start()

  local changes = {}
  if #result > 0 then
    changes = vim.split(result[1], ",", { trimempty = true })
  else
    return ""
  end

  local extractNumberValue = function(val)
    if not val then
      return ""
    end
    local parts = vim.split(val, " ", { trimempty = true })
    if not parts then
      return ""
    end
    if #parts > 0 then
      return parts[1]
    end
    return ""
  end

  local style = function(type, value)
    if value == "" or value == nil then
      return ""
    end
    return colors[type] .. chars[type] .. value .. "%#Normal#" .. " "
  end

  local files = extractNumberValue(changes[1])
  local inserts = extractNumberValue(changes[2])
  local removed = extractNumberValue(changes[3])

  return style("files", files) .. style("changed", inserts) .. style("removed", removed)
end

function providers.filetype()
  local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")

  if utils.isNil(buf_ft) then
    return ""
  end

  return buf_ft
end

function providers.lsp()
  local clients = vim.lsp.buf_get_clients()
  local names = {}

  for _, client in pairs(clients) do
    if client.name ~= "null-ls" then
      table.insert(names, client.name)
    end
  end

  if #names > 0 then
    return utils.dim("lsp: " .. table.concat(names, ", "))
  end

  return ""
end

function providers.lsp_enabled()
  local buffer = vim.api.nvim_get_current_buf()
  local buffer_clients = vim.lsp.buf_get_clients(buffer)
  local attached_lsps = {}

  for _, v in pairs(buffer_clients) do
    table.insert(attached_lsps, v.name)
  end

  if #attached_lsps == 0 then
    return false
  end

  return true
end

function providers.lsp_or_filetype()
  if not providers.lsp_enabled() then
    return "%="
  end

  if #providers.lsp() > 0 then
    return providers.lsp()
  elseif #providers.filetype() > 0 then
    return providers.filetype()
  end

  return "%="
end

function providers.file_icon()
  local ft = providers.filetype()

  if ft == "" then
    return ""
  end

  local icon = utils.get_icon_by_filetype(ft)
  return icon
end

local function get_diagnostic_info(level)
  if vim.diagnostic.is_disabled(0) then
    return ""
  end

  local signs = {
    core.diagnosticSigns[1].text,
    core.diagnosticSigns[2].text,
    core.diagnosticSigns[3].text,
    core.diagnosticSigns[4].text,
  }

  local count = #vim.diagnostic.get(0, { level = level })
  return count == 0 and "" or signs[level] .. " " .. tostring(count) .. " "
end

function providers.diagnostic()
  local errors = get_diagnostic_info(1)
  local warnings = get_diagnostic_info(2)
  local hints = get_diagnostic_info(3)
  local info = get_diagnostic_info(4)

  local sb = {}

  table.insert(sb, "%#" .. core.diagnosticSigns[1].name .. "#")
  table.insert(sb, errors)

  table.insert(sb, "%#" .. core.diagnosticSigns[2].name .. "#")
  table.insert(sb, warnings)

  table.insert(sb, "%#" .. core.diagnosticSigns[3].name .. "#")
  table.insert(sb, hints)

  table.insert(sb, "%#" .. core.diagnosticSigns[4].name .. "#")
  table.insert(sb, info)

  table.insert(sb, "%#Normal#")

  return table.concat(sb)
end

function providers.filename()
  local bufnr = vim.api.nvim_get_current_buf()
  local name = vim.fn.bufname(bufnr)
  if name == "" then
    return ""
  end

  if string.len(vim.fn.fnamemodify(name, ":.")) > 50 then
    return utils.dim(vim.fn.fnamemodify(name, ":t"))
  end

  return utils.dim(vim.fn.fnamemodify(name, ":."))
end

function providers.dim(value)
  return utils.dim(value)
end

local function alias_mode()
  return {
    --Normal
    ['n'] = 'Normal',
    ['no'] = 'O-Pending',
    ['nov'] = 'O-Pending',
    ['noV'] = 'O-Pending',
    ['no\x16'] = 'O-Pending',
    ['niI'] = 'Normal',
    ['niR'] = 'Normal',
    ['niV'] = 'Normal',
    ['nt'] = 'Normal',
    ['ntT'] = 'Normal',
    ['v'] = 'Visual',
    ['vs'] = 'Visual',
    ['V'] = 'V-Line',
    ['Vs'] = 'V-Line',
    ['\x16'] = 'V-Block',
    ['\x16s'] = 'V-Block',
    ['s'] = 'Select',
    ['S'] = 'S-Line',
    ['\x13'] = 'S-Block',
    ['i'] = 'Insert',
    ['ic'] = 'Insert',
    ['ix'] = 'Insert',
    ['R'] = 'Replace',
    ['Rc'] = 'Replace',
    ['Rx'] = 'Replace',
    ['Rv'] = 'V-Replace',
    ['Rvc'] = 'V-Replace',
    ['Rvx'] = 'V-Replace',
    ['c'] = 'Command',
    ['cv'] = 'Ex',
    ['ce'] = 'Ex',
    ['r'] = 'Replace',
    ['rm'] = 'More',
    ['r?'] = 'Confirm',
    ['!'] = 'Shell',
    ['t'] = 'Terminal',
  }
end

function providers.mode()
  local alias = alias_mode()
  local mode = vim.api.nvim_get_mode().mode
  return alias[mode] or alias[string.sub(mode, 1, 1)] or "UNK"
end

local statusline = {
  builtins = builtins,
  providers = providers,
}

return statusline
