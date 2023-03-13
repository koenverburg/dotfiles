local function augroup(name)
  return vim.api.nvim_create_augroup("apache" .. name, { clear = true })
end

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd({ "VimResized" }, {
  group = augroup("resize_splits"),
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

-- vim.api.nvim_create_autocmd("FileType", {
--   group = augroup("close_with_q"),
--   pattern = {
--     "PlenaryTestPopup",
--     "help",
--     "lspinfo",
--     "man",
--     "notify",
--     "qf",
--     "query", -- :InspectTree
--     "spectre_panel",
--     "startuptime",
--     "tsplayground",
--   },
--   callback = function(event)
--     vim.bo[event.buf].buflisted = false
--     -- vim.keymap.set("n", "<leader>q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
--     -- vim.keymap.set("n", "<leader>q", "<cmd>qall<cr>", { buffer = event.buf, silent = true })
--   end,
-- })

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("wrap_spell"),
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})
