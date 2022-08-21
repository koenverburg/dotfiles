require("nvim-tree").setup({
  view = {
    float = {
      enable = true,
      open_win_config = {
        relative = "editor",
        border = "rounded",
        width = 30,
        height = 30,
        row = 1,
        col = 1,
      },
    }
  }
})
