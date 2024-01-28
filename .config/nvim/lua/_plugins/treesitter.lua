require('global')
local normal = require("logic.functions").normal

if Is_enabled("treesitter") then
  local function dropCaptures()
    local result = vim.treesitter.get_captures_at_cursor(0)
    vim.notify(table.concat(result, ' '))
    -- print(vim.inspect(result))

    -- local id = vim.fn.synID(vim.fn.line("."), vim.fn.col("."), 0)
    -- local transId = vim.fn.synIDtrans(id)
    -- local name = vim.fn.synIDattr(id, "name")
    -- print(vim.inspect(transId, name))

    -- local function get_hl(name)
    --   local ok, hl = pcall(vim.api.nvim_get_hl_by_name, name, true)
    --   if not ok then
    --     return
    --   end
    --   for _, key in pairs({ "foreground", "background", "special" }) do
    --     if hl[key] then
    --       hl[key] = string.format("#%06x", hl[key])
    --     end
    --   end
    --   return hl
    -- end
    -- print(result[1])

    -- local v = get_hl('@' ..  result[1])
    -- if v then
    --   for key, value in pairs(v) do
    --     print(key .. ' ' .. value)
    --   end
    -- end
  end
  normal("<leader>fc", dropCaptures)
end

return {
  {
    "nvim-treesitter/nvim-treesitter",
    version = false,
    build = ":TSUpdate",
    event = LoadOnBuffer,
    enabled = Is_enabled("treesitter"),
    dependencies = {
      "filNaj/tree-setter",
      "nvim-treesitter/playground",
      "nvim-treesitter/nvim-treesitter-refactor",
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
        lazy = true,
      },
    },

    opts = {
      highlight = { enable = true, additional_vim_regex_highlighting = true },
      indent = { enable = true },
      ensure_installed = {
        "vim",
        "regex",
        "css",
        "go",
        "query",
        "graphql",
        "html",
        "javascript",
        "jsdoc",
        "json",
        "markdown",
        "markdown_inline",
        "tsx",
        "typescript",
        "yaml",
        "lua",
        "gitcommit",
      },
      -- context_commentstring = {
      --   enable = true,
      --   config = {
      --     json = "// %s",
      --     yml = "# %s",
      --     yaml = "# %s",
      --
      --     css = "// %s",
      --     scss = "// %s",
      --
      --     js = "// %s",
      --     ts = "// %s",
      --   },
      -- },
      tree_setter = {
        enable = false,
      },
      refactor = {
        smart_rename = {
          enable = true,
          -- Assign keymaps to false to disable them, e.g. `smart_rename = false`.
          keymaps = {
            smart_rename = "gr",
          },
        },
      },
    },

    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}
