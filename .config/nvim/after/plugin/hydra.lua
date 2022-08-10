local Hydra = require "hydra"

Hydra {
  name = "Change / Resize Window",
  mode = { "n" },
  body = "<leader>w",
  config = {
    -- color = "pink",
  },
  heads = {
    -- move between windows
    { "h", "<C-w>h" },
    { "j", "<C-w>j" },
    { "k", "<C-w>k" },
    { "l", "<C-w>l" },

    -- resizing window
    { "H", "<C-w>3<" },
    { "L", "<C-w>3>" },
    { "K", "<C-w>2+" },
    { "J", "<C-w>2-" },

    -- equalize window sizes
    { "e", "<C-w>=" },

    -- close active window
    { "Q", ":q<cr>" },
    { "<C-q>", ":q<cr>" },

    -- exit this Hydra
    { "q", nil, { exit = true, nowait = true } },
    { ";", nil, { exit = true, nowait = true } },
    { "<Esc>", nil, { exit = true, nowait = true } },
  },
}

-- Hydra {
--   name = "LSP",
--   mode = { "n" },
--   body = "<leader>l",
--   config = {},
--   heads = {
--
--     -- exit this Hydra
--     { "q", nil, { exit = true, nowait = true } },
--     { ";", nil, { exit = true, nowait = true } },
--     { "<Esc>", nil, { exit = true, nowait = true } },
--   },
-- }
