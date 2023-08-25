local handle = io.popen("tty")
local tty = handle:read("*a")
handle:close()

local reset = function()
	os.execute('printf "\\033]111\\007" > ' .. tty)
end

local update = function()
	local normal = vim.api.nvim_get_hl_by_name("Normal", true)

  -- print(normal['background'], normal['foreground'])

	local bg = normal["background"]
	local fg = normal["foreground"]
	if bg == nil then
		return reset()
	end

	local bghex = string.format("#%06x", bg)
	local fghex = string.format("#%06x", fg)

	if os.getenv("TMUX") then
    -- print('tmux is active')
		os.execute('printf "\\ePtmux;\\e\\033]11;' .. bghex .. '\\007\\e\\\\"')
		os.execute('printf "\\ePtmux;\\e\\033]12;' .. fghex .. '\\007\\e\\\\"')
	else
    -- print('tmux is NOT active')
		os.execute('printf "\\033]11;' .. bghex .. '\\007" > ' .. tty)
		os.execute('printf "\\033]12;' .. fghex .. '\\007" > ' .. tty)
	end
end

local setup = function()

  if vim.fn.exists('+termguicolors') == 1 then
    vim.api.nvim_command('let &t_8f = "\\<Esc>[38;2;%lu;%lu;%lum"')
    vim.api.nvim_command('let &t_8b = "\\<Esc>[48;2;%lu;%lu;%lum"')
    -- vim.opt.termguicolors = true
  end
  -- print("hii")
  update()
	vim.api.nvim_create_autocmd({ "ColorScheme", "UIEnter" }, { callback = update })
	vim.api.nvim_create_autocmd({ "VimLeavePre" }, { callback = reset })
end

setup()
