-- Inspired by https://github.com/aktersnurra/minibar.nvim
local opts = {
  ["ignore-filetypes"] = { "help", "startify", "dashboard", "packer", "NvimTree", "Trouble", "alpha", "Outline", "lazy" },
  events = { "CursorMoved", "CursorHold", "BufWinEnter", "BufFilePost", "InsertEnter", "BufWritePost", "TabClosed" },
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

local function get_icon_by_filetype(name)
  local ok, icons = pcall(require, "nvim-web-devicons")

  if not ok then
    return ""
  end

  local icon, _ = icons.get_icon_by_filetype(name)
  if not icon then
    return ""
  end

  return icon .. " "
end

local function main()
  if (ignore() ~= true) and (is_nil(get_filename()) == false) then
    local bar = get_icon_by_filetype(get_filetype()) .. "%t%m" .. "%=" .. "%l/%L"

    return vim.api.nvim_set_option_value("winbar", (" " .. bar), { scope = "local" })
  else
    vim.opt_local.winbar = nil
    return nil
  end
end

vim.api.nvim_create_autocmd(opts.events, { callback = main })
