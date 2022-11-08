local lines = {}

lines.tabline = function()
  require("minimal-tabline").setup {
    enable = true,
    file_name = false,
    tab_index = true,
    pane_count = false,
    modified_sign = true,
    no_name = "[No Name]",
  }
end

local ok, plenary_reload = pcall(require, "plenary.reload")
if not ok then
  reloader = require
else
  reloader = plenary_reload.reload_module
end

RELOAD = function(...)
  return reloader(...)
end

R = function(name)
  RELOAD(name)
  return require(name)
end


lines.statusline = function()
  -- local helper = require "el.helper"
  local subscribe = require "el.subscribe"
  local extensions = require "el.extensions"
  local builtin = require "el.builtin"
  local sections = require "el.sections"
  -- local lsp_statusline = require "el.plugins.lsp_status"
  -- local has_lsp_status, lsp_status = pcall(require, 'lsp-status')

  local git_branch = subscribe.buf_autocmd("el_git_branch", "BufEnter", function(window, buffer)
    local branch = extensions.git_branch(window, buffer)
    if branch then
      return " " .. extensions.git_icon() .. " " .. branch
    end
  end)

  local shortened_file = function(_, buffer)
    if buffer.name == "" then
      return builtin.file(_, buffer)
    end

    if string.len(vim.fn.fnamemodify(buffer.name, ":.")) > 50 then
      return vim.fn.fnamemodify(buffer.name, ":t")
    end

    return vim.fn.fnamemodify(buffer.name, ":.")
  end

  local show_lsp_status = function(_, buffer)
    local buffer_clients = vim.lsp.buf_get_clients(buffer.bufnr)
    local attached_lsps = {}

    for _, v in pairs(buffer_clients) do
      table.insert(attached_lsps, v.name)
    end

    local lsps = table.concat(attached_lsps, ', ')

    return "lsps: " .. lsps
  end

  local generator = function(_, _) -- window, bufnr
    local segments = {}

    table.insert(segments, " ")
    table.insert(segments, extensions.mode)
    table.insert(segments, git_branch)
    table.insert(segments, " ")

    table.insert(segments, sections.split)
    table.insert(segments, shortened_file)
    table.insert(segments, builtin.modified)
    table.insert(segments, " ")
    table.insert(
      segments,
      subscribe.buf_autocmd("el_file_icon", "BufRead", function(_, buffer)
        return extensions.file_icon(_, buffer)
      end)
    )

    table.insert(segments, sections.split)
    table.insert(segments, show_lsp_status)
    table.insert(segments, sections.collapse_builtin(builtin.help_list, builtin.readonly_list))
    table.insert(segments, " ")
    table.insert(segments, builtin.filetype)
    table.insert(segments, " ")
    -- table.insert(
    --   segments,
    --   subscribe.buf_autocmd("el_git_status", "BufWritePost", function(window, buffer)
    --     local changes = extensions.git_changes(window, buffer)
    --     if changes then
    --       return " " .. changes .. " "
    --     end
    --   end)
    -- )
    --
    return segments
  end
  R('el').setup({ generator = generator })
end

return lines
