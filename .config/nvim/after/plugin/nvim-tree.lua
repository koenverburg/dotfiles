require("nvim-tree").setup({
  view = {
    float = {
      enable = true,
      open_win_config = {
        relative = "editor",
        border = "rounded",
        width = 200,
        height = 50,
        row = 5,
        col = 5,
      },
    }
  }
})
