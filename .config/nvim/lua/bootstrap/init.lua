local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

-- local manager_exists = vim.loop.fs_stat(lazypath)
-- if not manager_exists then
--   if vim.fn.input "Download Lazy? (y for yes)" ~= "y" then
--     return
--   end
--
--   local directory = string.format("%s/site/pack/packer/opt/", vim.fn.stdpath "data")
--   vim.fn.mkdir(directory, "p")
--
--   local out = vim.fn.system(
--     string.format('git clone %s "%s"', "https://github.com/wbthomason/packer.nvim", directory .. "/packer.nvim")
--   )
--
--   print(out)
--   print "Downloading packer.nvim..."
--   print "( You'll need to restart now )"
--
--   return
-- end
