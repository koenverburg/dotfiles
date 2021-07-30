local border_opts = {
  topleft  = "┌",
  topright = "┐",
  top      = "─",
  left     = "│",
  right    = "│",
  botright = "┘",
  botleft  = "└",
  bot      = "─"
}


local createPopup = function(name)
  local plenary_window = require('plenary.window.float').percentage_range_window(0.5, 0.2, nil, border_opts)
  vim.api.nvim_buf_set_option(plenary_window.bufnr, 'buftype', 'prompt')

  vim.fn.prompt_setprompt(plenary_window.bufnr, name) 

  vim.fn.prompt_setcallback(plenary_window.bufnr, function(text)
    vim.api.nvim_win_close(plenary_window.win_id, true)

    if text ~= "" then
      return text
    else
      print "No input given!"
    end
  end)

  vim.cmd [[ startinsert ]]
end


-- createPopup('prefix:')
-- createPopup('scope:')
-- createPopup('title:')
-- createPopup('body:')
-- createPopup('tags:')
