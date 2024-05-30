local core = require('core.config')
-- Inspired by https://github.com/aktersnurra/minibar.nvim
local opts = {
  ["ignore-filetypes"] = {
    "help",
    "startify",
    "dashboard",
    "packer",
    "NvimTree",
    "Trouble",
    "alpha",
    "Outline",
    "lazy",
  },
  events = {
    "CursorMoved",
    "CursorHold",
    "BufWinEnter",
    "BufEnter",
    "BufFilePost",
    "InsertEnter",
    "BufWritePost",
    "TabClosed",
  },
}

local function is_nil(val)
  return ((val == nil) or (val == ""))
end

local function get_filetype()
  return vim.bo.filetype
end

local function get_filename()
  return vim.fn.expand("%:t")
end

local function ignore()
  return vim.tbl_contains(opts["ignore-filetypes"], get_filetype())
end

local function get_icon_by_filetype(ft)
  local ok, icons = pcall(require, "nvim-web-devicons")

  if not ok then
    return ""
  end

  if not ft then
    return ""
  end

  local icon, color = icons.get_icon_by_filetype(ft)

  if not icon then
    return ""
  end

  return "%#" .. color .. "#" .. icon .. "%#Normal#" .. " "
end

local function get_git_status(type)
  local chars = {
    added = "",
    changed = "~",
    removed = "",
  }

  local colors = {
    added = "%#GitSignsAdd#",
    changed = "%#GitSignsChange#",
    removed = "%#GitSignsDelete#",
  }

  if not vim.b.gitsigns_status_dict then
    return ""
  end

  if not vim.b.gitsigns_status_dict[type] then
    return ""
  end

  if vim.b.gitsigns_status_dict[type] > 0 then
    return colors[type] .. chars[type] .. vim.b.gitsigns_status_dict[type] .. "%#Normal#" .. " "
  end

  return ""

  -- {
  --   added = 4,
  --   changed = 0,
  --   removed = 0,
  --   head = "main",
  --   gitdir = "/Users/koenverburg/code/github/dotfiles/.git",
  --   root = "/Users/koenverburg/code/github/dotfiles"
  -- }
end

-- local function get_diagnostic_info(level)
--   if vim.diagnostic.is_disabled(0) then
--     return ""
--   end
--
--   local signs = {
--     core.diagnosticSigns[1].text,
--     core.diagnosticSigns[2].text,
--     core.diagnosticSigns[3].text,
--     core.diagnosticSigns[4].text,
--   }
--
--   local count = #vim.diagnostic.get(0, { level = level })
--   return count == 0 and "" or signs[level] .. " " .. tostring(count) .. " "
-- end
--
-- local function diagnostic()
--   if vim.diagnostic.is_disabled(0) then
--     return ""
--   end
--   local errors   = get_diagnostic_info(1)
--   local warnings = get_diagnostic_info(2)
--   local hints    = get_diagnostic_info(3)
--   local info     = get_diagnostic_info(4)
--
--   local sb = {}
--
--   table.insert(sb, "%#" .. core.diagnosticSigns[1].name .. "#")
--   table.insert(sb, errors)
--
--   table.insert(sb, "%#" .. core.diagnosticSigns[2].name .. "#")
--   table.insert(sb, warnings)
--
--   table.insert(sb, "%#" .. core.diagnosticSigns[3].name .. "#")
--   table.insert(sb, hints)
--
--   table.insert(sb, "%#" .. core.diagnosticSigns[4].name .. "#")
--   table.insert(sb, info)
--
--   table.insert(sb, "%#Normal#")
--
--   return table.concat(sb) or " "
-- end
--

local function main()
  -- local trouble = diagnostic()

  if (ignore() ~= true) and (is_nil(get_filename()) == false) then
    local added = get_git_status("added")
    local changed = get_git_status("changed")
    local removed = get_git_status("removed")

    -- todo make this a table
    local bar = {
      " ",
      get_icon_by_filetype(get_filetype()),
      "%t%m",
      "%=",
      added,
      changed,
      removed,
      "%=",
      -- "%=",
      "%c",
      " ",
      "%l/%L",
    }

    return vim.api.nvim_set_option_value("winbar", table.concat(bar, ""), { scope = "local" })
  else
    vim.opt_local.winbar = nil
    return nil
  end
end

vim.api.nvim_create_autocmd(opts.events, { callback = main })
