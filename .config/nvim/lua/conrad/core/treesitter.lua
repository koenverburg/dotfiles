require("nvim-treesitter.configs").setup({
	highlight = { enable = true },
	indent = { enable = true },
	ensure_installed = {
		"yaml",
		"tsx",
		"typescript",
		"graphql",
		"jsdoc",
		"javascript",
		"html",
		"json",
		"css",
		-- "lua",
		"go",
	},
	context_commentstring = {
		enable = true,
		config = {
			yml = "# ",
			yaml = "# ",

			css = "// %s",
			scss = "// %s",

			js = "// %s",
			ts = "// %s",
			tsx = {
				__default = "// %s",
				jsx_element = "{/* %s */}",
				jsx_fragment = "{/* %s */}",
				jsx_attribute = "{/* %s */}",
				comment = "// %s",
			},
			jsx = {
				__default = "// %s",
				jsx_element = "{/* %s */}",
				jsx_fragment = "{/* %s */}",
				jsx_attribute = "{/* %s */}",
				comment = "// %s",
			},
		},
	},
	textobjects = {
		select = {
			enable = true,
			keymaps = {
				-- keybindings are triggered in visual mode only
				["af"] = "@function.outer",
				["if"] = "@function.inner",

				["ac"] = "@class.outer",
				["ic"] = "@class.inner",

				["ab"] = "@block.outer",
				["ib"] = "@block.inner",
			},
		},
		swap = {
			enable = true,
			swap_next = {
				["<leader>a"] = "@parameter.inner",
			},
			swap_previous = {
				["<leader>A"] = "@parameter.inner",
			},
		},
		-- revise these commands
		move = {
			enable = true,
			set_jumps = false, -- whether to set jumps in the jumplist
			goto_next_start = {
				["]m"] = "@function.outer",
				["]]"] = "@class.outer",
			},
			goto_next_end = {
				["]M"] = "@function.outer",
				["]["] = "@class.outer",
			},
			goto_previous_start = {
				["[m"] = "@function.outer",
				["[["] = "@class.outer",
			},
			goto_previous_end = {
				["[M"] = "@function.outer",
				["[]"] = "@class.outer",
			},
		},
	},
})
