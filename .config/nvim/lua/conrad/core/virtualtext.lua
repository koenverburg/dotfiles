local ts_utils = require 'nvim-treesitter.ts_utils'

local conrad_ns_vt = vim.api.nvim_create_namespace('conrad_ns_vt')

local opts = {}

local targets = {
  -- Lua
  'function_name',

  'function',
  'method_declaration',
  'function_declaration',
  'function_definition',
  'local_function',
  'arrow_function',
  'method_definition',

  'class_declaration', 'struct_expression',

  'test_expression',

  -- typescript
  'interface_declaration',
  'enum_declaration',

  -- Go,
  'identifier',
  'source_file'
}

local M = {}

local function setVirtualText(node)
  if vim.tbl_contains(targets, node:type()) then
    local targetLineNumber = node:start();

    -- local virtualText
    -- if opts.custom_text_handler then
    --   virtualText = opts.custom_text_handler(node)
    -- else
    --   virtualText = " ### " .. "Helloo virtual text"
    -- end

    local virtualText = " ### " .. "Helloo virtual text"

    -- Add a guard here to allow users to filter which node to show virtual text
    if not virtualText then
      print('no vt')
      return
    end

    vim.api.nvim_buf_set_virtual_text(0, conrad_ns_vt, targetLineNumber, {{ virtualText, 'Comment' }}, {});
  end
end

function M.show()
  vim.api.nvim_buf_clear_namespace(0, conrad_ns_vt, 0, -1)

  if node == nil then
    node = ts_utils.get_node_at_cursor();
  end

  if not node then
    print("no node found")
    return
  end

  setVirtualText(node)
end

return M
