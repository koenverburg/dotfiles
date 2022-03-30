require "nvim-treesitter"
local utils = require "conrad.utils"
local ts_parsers = require "nvim-treesitter.parsers"

local P = utils.P

local M = {}
local ns = vim.api.nvim_create_namespace "conrad/hints"

-- local function get_hover_params(line, bufnr)
--   local fn = vim.uri_from_bufnr(bufnr)
--   return {
--     textDocument = { uri = fn },
--     position = { line = line }, --, character = node.character },
--     bufnr = bufnr,
--   }
-- end

-- local function handler(_, method, result)
--   if not (result and result.contents) then
--     print "no results"
--     return
--   end
--
--   local markdown_lines = vim.lsp.util.convert_input_to_markdown_lines(result.contents)
--   markdown_lines = vim.lsp.util.trim_empty_lines(markdown_lines)
--
--   if vim.tbl_isempty(markdown_lines) then
--     print "No lines"
--     return
--   end
--
--   utils.P(markdown_lines)
-- end

local attached_buffers = {}
function M.show()
  -- local buf_number = vim.api.nvim_buf_get_number "%"

  local buffer_number = vim.api.nvim_get_current_buf()
  local parameter = vim.lsp.util.make_position_params()
  local response = vim.lsp.buf_request_sync(buffer_number, "textDocument/codeLens", parameter)

  utils.P(response)

  for _, v in ipairs(response) do
      if v == nil or v["result"] == nil then return end -- no response
      P(v)

      for _,vv in pairs(v["result"]) do
        if vv["range"] and vv["command"] then

          local start_line = -1
          for _,vvv in pairs(vv["range"]) do
            start_line = tonumber(vvv["line"])
          end

          for _,vvv in pairs(vv["command"]) do
            if vvv == nil or vvv == "" then
              goto skip_to_next
            end

            local msg = {vvv, "TypeAnnot"}

            utils.P(msg)
            -- set_virtual_text(buffer_number, virtual_types_ns, start_line, msg)
            ::skip_to_next::
          end
        end
      end
    end

  -- if attached_buffers[buf_number] then
  --   return
  -- end
  -- attached_buffers[buf_number] = true
  --
  -- local lang = ts_parsers.get_buf_lang(bufnr):gsub("-", "")
  --
  -- local query = {
  --   go = [[
  --   (short_var_declaration) @vars
  -- ]],
  --   typescript = [[
  --   (variable_declarator) @declvars
  -- ]],
  -- }
  --
  -- -- (var_declaration) @vars
  --
  -- if not query[lang] then
  --   print(string.format("Unsupported languages found: %s", lang))
  --   return
  -- end
  --
  -- local matches = utils.get_query_matches(bufnr, query[lang])
  -- if matches == nil then
  --   return
  -- end
  --
  -- local results = {}
  -- for _, match, metadata in matches do
  --   -- utils.P(getmetatable(match[1]))
  --   table.insert(results, {
  --     node_type = match[1]:type(),
  --     start_line = match[1]:start(),
  --
  --     kind = vim.lsp.protocol.SymbolKind[match[1]:symbol()] or "ahii",
  --
  --     range= match[1]:range(),
  --     symbol = match[1]:symbol(),
  --   })
  -- end

  -- for _, v in ipairs(results) do
  --   utils.P(v)
  --   utils.setVirtualText(ns, v.start_line, v.kind, "--")
  -- end

  -- utils.P(getmetatable(captures[1]))
  -- utils.P(lsp_proto.SymbolKind[node:symbol()] or "Unknown")
end

return M
