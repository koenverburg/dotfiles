local colors = {
  sepia_fg = '#E3D1B2',
  sepia_bg = '#8C7465',
  -- ... other color definitions ...
}

vim.cmd('hi Normal guifg=' .. colors.sepia_fg .. ' guibg=' .. colors.sepia_bg)
vim.cmd('hi LspReferenceText guibg=' .. colors.sepia_bg)
