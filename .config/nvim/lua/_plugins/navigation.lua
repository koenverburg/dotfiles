local is_enabled = require("_apache.functions").is_enabled

return {
  {
    "roobert/tabtree.nvim",
    enabled = is_enabled("tabtree"),
    lazy = false,
    -- keys = {
    --   { "[", "<cmd>lua require('tabtree').previous()<cr>" },
    --   { "]", "<cmd>lua require('tabtree').next()<cr>" },
    -- },
    config = function()
      require("tabtree").setup({
        key_bindings = {
          next = "[",
          previous = "]",
        },
        language_configs = {
          typescript = {
            target_query = [[
              (function) @captures
              (arrow_function) @captures
              (method_definition) @captures
              (lexical_declaration) @captures
              (function_declaration) @captures
              (generator_function_declaration) @captures
            ]],
            -- (string) @string_capture
            -- (interpolation) @interpolation_capture
            -- (parameters) @parameters_capture
            -- (argument_list) @argument_list_capture
            -- experimental feature, to move the cursor in certain situations like when handling python f-strings
            offsets = {
              string_start_capture = 1,
            },
          },
        },
      })
    end,
  },
  {
    "numToStr/Navigator.nvim",
    enabled = is_enabled("tmux"),
    lazy = false,
    config = function()
      require("Navigator").setup()
    end,
  },
}
