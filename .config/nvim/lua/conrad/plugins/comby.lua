local Job = require "plenary.job"
local term = require('lspsaga.floaterm')

local async = require "plenary.async"
local utils = require "conrad.utils"
local normal = utils.normal

local M = {}

function M.main()
  local match = vim.fn.input "match > "
  local rewrite = vim.fn.input "rewrite > "
  local files = vim.fn.input "files > "
  local apply = ''

  if vim.fn.input "Apply changes? (y for yes)" ~= "y" then
    apply = '-i'
  end

  local cmd = string.format('comby "%s" "%s" %s %s', match, rewrite, files, apply)

  term.open_float_terminal(cmd)
end

return M

