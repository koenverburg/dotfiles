local api, uv, lsp = vim.api, vim.uv, vim.lsp
local p = {}

-- #region stl bg
local function get_stl_bg()
  local res = api.nvim_get_hl(0, { name = 'StatusLine' })
  if vim.tbl_isempty(res) then
    vim.notify('[Whisky] colorschem missing StatusLine config')
    return
  end
  return res.bg
end

local stl_bg
if not stl_bg then
  stl_bg = get_stl_bg()
end

local function stl_attr(group, trans)
  local color = api.nvim_get_hl(0, { name = group, link = false })
  trans = trans or false
  return {
    bg = trans and 'NONE' or stl_bg,
    fg = color.fg,
  }
end

-- #endregion

-- #region modes
local function alias_mode()
  return {
    --Normal
    ["n"] = "Normal",
    ["no"] = "O-Pending",
    ["nov"] = "O-Pending",
    ["noV"] = "O-Pending",
    ["no\x16"] = "O-Pending",
    ["niI"] = "Normal",
    ["niR"] = "Normal",
    ["niV"] = "Normal",
    ["nt"] = "Normal",
    ["ntT"] = "Normal",
    ["v"] = "Visual",
    ["vs"] = "Visual",
    ["V"] = "V-Line",
    ["Vs"] = "V-Line",
    ["\x16"] = "V-Block",
    ["\x16s"] = "V-Block",
    ["s"] = "Select",
    ["S"] = "S-Line",
    ["\x13"] = "S-Block",
    ["i"] = "Insert",
    ["ic"] = "Insert",
    ["ix"] = "Insert",
    ["R"] = "Replace",
    ["Rc"] = "Replace",
    ["Rx"] = "Replace",
    ["Rv"] = "V-Replace",
    ["Rvc"] = "V-Replace",
    ["Rvx"] = "V-Replace",
    ["c"] = "Command",
    ["cv"] = "Ex",
    ["ce"] = "Ex",
    ["r"] = "Replace",
    ["rm"] = "More",
    ["r?"] = "Confirm",
    ["!"] = "Shell",
    ["t"] = "Terminal",
  }
end

function p.mode()
  local alias = alias_mode()
  local result = {
    stl = function()
      local mode = api.nvim_get_mode().mode
      return alias[mode] or alias[string.sub(mode, 1, 1)] or "UNK"
    end,
    name = "mode",
    default = "Normal",
    event = { "ModeChanged" },
    attr = stl_attr("Constant"),
  }
  return result
end

-- #endregion

function p.example()
  return {
    name = "name",
    stl = "value",
    event = { "BufEnter" },
    attr = {
      bold = true,
      bg = stl_bg,
    },
  }
end

return p
