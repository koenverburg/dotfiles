local ts_utils = require 'nvim-treesitter.ts_utils';

local opts = {}

local targets = {
  'function',
  'method_declaration',
  'function_declaration',
  'function_definition',
  'local_function',
  'arrow_function',
  'method_definition',
  'arguments',

  'if_statement',
  'if_expression',

  'switch_expression',

  'class_declaration',
  'struct_expression',

  'test_expression',

  'while_expression',
  'while_statement',

  'for_expression',
  'foreach_statement',
  'for_statement',
  'for_in_statement',

  -- rust
  'match_expression',
  'if_let_expression',
  'tuple_struct_pattern',
  'while_let_expression',
  'for_expression',
  'loop_expression',
  'function_item',
  'struct_item',

  -- ruby target
  'class',
  'module',
  'method',
  'do_block',
  'if',
  'while',
  'for',

  -- typescript
  'interface_declaration',
  'enum_declaration',

  -- Go,
  'identifier',
  'source_file'
}

local M = {}

function M.setup(user_opts)
	opts = vim.tbl_extend('force', opts, user_opts or {})
end

local function setVirtualText(node)
  if vim.tbl_contains(targets, node:type()) then
    local targetLineNumber = node:start();

    print(targetlinenumber)

    local virtualText

    if opts.custom_text_handler then
      virtualText = opts.custom_text_handler(node)
    else
      virtualText = " ### " .. "Helloo virtual text"
    end

    -- Add a guard here to allow users to filter which node to show virtual text
    if not virtualText then
      return
    end

    vim.api.nvim_buf_set_virtual_text(0, vim.g.context_vt_namespace, targetLineNumber, {{ virtualText, 'Comment' }}, {});
  end
end

function M.showContext()
  -- if node == nil then
  --   -- Clear the existing.
  --   -- Get the node at the current position.
  --   -- node = ts_utils.get_node_at_cursor();
  -- end

  -- vim.api.nvim_buf_clear_namespace(0, vim.g.context_vt_namespace, 0, -1);
  -- node = ts_utils.root();
  local bufnr = vim.fn.bufnr()
  print(bufnr)

  local parser = vim.treesitter.get_parser(bufnr, "go")
  local tstree = parser.parse()

  local node = tstree:root()

  if not node then
    return
  end

  print(vim.inspect(node))

  -- local parentNode = node:parent();

  -- setVirtualText(node)

  -- if not parentNode then
  --   return
  -- end

  -- setVirtualText(parentNode)

  -- if parentNode and not (parentNode:type() == 'program') then
  --   M.showContext(parentNode);
  -- end
end


return M

 vim.cmd [[ autocmd CursorMoved * :lua require 'conrad.core.virtualtext'.showContext() ]]
 vim.cmd [[ autocmd CursorMovedI * lua require 'conrad.core.virtualtext'.showContext() ]]
