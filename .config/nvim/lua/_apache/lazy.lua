require("lazy").setup({
	spec = {
		{ import = "_plugins" },
	},

	defaults = {
		lazy = true,
		version = false,
	},

	checker = { enabled = true },

	performance = {
		rtp = {
			disabled_plugins = {
				"gzip",
        "tar",
        "tarPlugin",
				"matchit",
				"matchparen",
				"netrwPlugin",
				"tohtml",
				"tutor",
        "zip",
				"zipPlugin",
        "netrw",
        "netrwPlugin",
        "netrwSettings",
        "netrwFileHandlers"
			},
		},
	},
})
