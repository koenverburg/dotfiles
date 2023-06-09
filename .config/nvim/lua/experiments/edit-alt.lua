local M = {}

local function path_sep()
  return vim.loop.os_uname().sysname == "Windows_NT" and "\\" or "/"
end

local opts = {
  patterns = {
    js = "spec.js",
    ts = "spec.ts",
    tsx = "spec.tsx",
  },
}

local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local topts = {}
local prompt = "Edit Alt"

local git = vim.tbl_flatten({
  "git",
  "ls-files",
  "--exclude-standard",
  "--cached",
  "--others",
})

local function openTelescope(title, query)
  local finder = finders.new_oneshot_job(git, {})

  pickers.new(topts, {
    finder = finder,
    results_title = title,
    default_text = query,
    prompt_title = "",
    sorter = conf.generic_sorter(topts),
  }):find()
end

M.edit = function()
  local sep = path_sep()
  local fname = vim.api.nvim_buf_get_name(0)
  local parts = vim.split(fname, sep, { trimempty = true })

  fname = table.concat({ unpack(parts, #parts) }, sep)

  -- get extention
  local extention = vim.fn.expand("%:e")
  -- map extention to opts patterns
  local pattern = opts.patterns[extention]

  if not pattern then
    vim.notify("edit-alt - No pattern found for " .. extention)
    return
  end

  local alt = ""

  -- implement reverse if test file and search for non test file
  -- If the current file is the alt file
  if string.find(fname, pattern) then
    alt = fname:gsub(pattern, extention)
  else
    alt = fname:gsub(extention, pattern)
  end

  openTelescope(prompt, alt)
end

M.filter_for = function(query)
  openTelescope("filter on " .. query, query .. " ")
end

return M
