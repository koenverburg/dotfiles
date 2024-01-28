require("global")
-- local normal = require("logic.functions").normal

local plugin = "nvim-tree"
local WIDTH_RATIO = 0.7
local HEIGHT_RATIO = 0.8

-- if Is_enabled(plugin) then
--   normal("<C-b>", "<cmd>NvimTreeToggle<cr>")
-- end

return {
  "nvim-tree/" .. plugin .. ".lua",
  enabled = Is_enabled(plugin),
  lazy = false,
  keys = {
    { "<C-b>", "<cmd>NvimTreeToggle<cr>", desc = "Open Nvim Tree" },
  },
  config = function()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    require("nvim-tree").setup({
      hijack_netrw = true,
      disable_netrw = true,
      respect_buf_cwd = true,
      sync_root_with_cwd = true,
      view = {
        relativenumber = false,
        float = {
          enable = true,
          open_win_config = function()
            local screen_w = vim.opt.columns:get()
            local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
            local window_w = screen_w * WIDTH_RATIO
            local window_h = screen_h * HEIGHT_RATIO
            local window_w_int = math.floor(window_w)
            local window_h_int = math.floor(window_h)
            local center_x = (screen_w - window_w) / 2
            local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()
            return {
              border = "rounded",
              relative = "editor",
              row = center_y,
              col = center_x,
              width = window_w_int,
              height = window_h_int,
            }
          end,
        },
        width = function()
          return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
        end,
      },
      -- filters = {
      --   custom = { "^.git$" },
      -- },
      -- renderer = {
      --   indent_width = 1,
      -- },
    })
  end,
}
