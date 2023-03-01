local gc = {}

function gc.get_all_buffers()
  local bufnrs = vim.api.nvim_list_bufs()

  if not next(bufnrs) then
    print "no bufnrs"
    return
  end

  local buffers = {}
  for _, bufnr in ipairs(bufnrs) do
    local flag = bufnr == vim.fn.bufnr "" and "%" or (bufnr == vim.fn.bufnr "#" and "#" or " ")

    local element = {
      bufnr = bufnr,
      flag = flag,
      info = vim.fn.getbufinfo(bufnr)[1],
    }

    table.insert(buffers, element)
  end

  return buffers
end

-- local visible_buffers = vim.tbl_filter(function(b)
--   if vim.api.nvim_buf_is_loaded(b.bufnr) and vim.api.nvim_buf_get_option(b.bufnr, "buflisted") then
--     return true
--   end
-- end, gc.get_all_buffers())

function gc.clean()
  -- get all hidden buffers
  local bufs = vim.tbl_filter(function(b)
    if not vim.api.nvim_buf_is_loaded(b.bufnr) then
      return true
    end
  end, gc.get_all_buffers())

  for _, value in ipairs(bufs) do
    vim.cmd(string.format("bdelete %d", value.bufnr))
  end
end

return gc
