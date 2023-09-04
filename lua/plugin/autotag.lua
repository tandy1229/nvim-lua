require('nvim-ts-autotag').setup()
require('nvim-treesitter.configs').setup({
	autotag = {
		enable = true,
		enable_rename = true,
		enable_close = true,
		enable_close_on_slash = true,
	},
})
