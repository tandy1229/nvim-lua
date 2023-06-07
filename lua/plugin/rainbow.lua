require('nvim-treesitter.configs').setup({
	rainbow = {
		enable = true,
		-- disable = { "jsx", "cpp" }, --list of languages you want to disable the plugin for
		disable = { 'latex' }, --list of languages you want to disable the plugin for
		query = 'rainbow-parens',
		-- Highlight the entire buffer all at once
		strategy = require('ts-rainbow').strategy.global,
		-- colors = {}, -- table of hex strings
		-- termcolors = {} -- table of colour name strings
	},
})
