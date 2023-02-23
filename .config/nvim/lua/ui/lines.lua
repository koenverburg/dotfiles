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

lines.winbar = function()
  vim.opt.winbar = "%t %-m %{%v:lua.require'nvim-navic'.get_location()%}"
end

lines.lualine = function()
  local c = require("kimbox.lualine").colors()
  local empty = require("lualine.component"):extend()

  function empty:draw(default_highlight)
    self.status = ""
    self.applied_separator = ""
    self:apply_highlights(default_highlight)
    self:apply_section_separators()
    return self.status
  end

  -- Put proper separators and gaps between components in sections
  local function process_sections(sections)
    for name, section in pairs(sections) do
      for pos = 1, name ~= "lualine_z" and #section or #section - 1 do
        table.insert(section, pos * 2, { empty, color = { fg = c.purple, bg = c.bg1 } })
      end
      for id, comp in ipairs(section) do
        if type(comp) ~= "table" then
          comp = { comp }
          section[id] = comp
        end
      end
    end
    return sections
  end

  local function show_lsp_status()
    local bufnr = vim.api.nvim_get_current_buf()
    local buffer_clients = vim.lsp.buf_get_clients(bufnr)
    local attached_lsps = {}

    for _, v in pairs(buffer_clients) do
      table.insert(attached_lsps, v.name)
    end

    local lsps = table.concat(attached_lsps, ", ")
    return "lsps: " .. lsps
  end

  local function search_result()
    if vim.v.hlsearch == 0 then
      return ""
    end
    local last_search = vim.fn.getreg "/"
    if not last_search or last_search == "" then
      return ""
    end
    local searchcount = vim.fn.searchcount { maxcount = 9999 }
    return last_search .. "(" .. searchcount.current .. "/" .. searchcount.total .. ")"
  end

  local function modified()
    if vim.bo.modified then
      return "+"
    elseif vim.bo.modifiable == false or vim.bo.readonly == true then
      return "-"
    end
    return ""
  end

  require("lualine").setup {
    options = {
      theme = 'kimbox',
      component_separators = "",
      section_separators = { left = "", right = "" },
      -- section_separators = { left = "", right = "" },
    },
    sections = process_sections {
      lualine_a = { "mode" },
      lualine_b = {
        "branch",
        "diff",
        {
          "diagnostics",
          source = { "nvim" },
          sections = { "error" },
          diagnostics_color = { error = { bg = c.red, fg = c.white} },
        },
        {
          "diagnostics",
          source = { "nvim" },
          sections = { "warn" },
          diagnostics_color = { warn = { bg = c.orange, fg = c.white } },
        },
        { "filename", file_status = false, path = 1 },
        { modified, color = { bg = c.red } },
        {
          "%w",
          cond = function()
            return vim.wo.previewwindow
          end,
        },
        {
          "%r",
          cond = function()
            return vim.bo.readonly
          end,
        },
        {
          "%q",
          cond = function()
            return vim.bo.buftype == "quickfix"
          end,
        },
      },
      lualine_c = {},
      lualine_x = {},
      lualine_y = { show_lsp_status, search_result, "filetype" },
      lualine_z = { "%l:%c", "%p%%/%L" },
    },
    inactive_sections = {
      lualine_c = { "%f %y %m" },
      lualine_x = {},
    },
  }
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

    local lsps = table.concat(attached_lsps, ", ")

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

    table.insert(segments, builtin.line)
    table.insert(segments, "/")
    table.insert(segments, builtin.number_of_lines)
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
  require("el").setup { generator = generator }
end

return lines
