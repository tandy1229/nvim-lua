vim.opt.list = true
vim.opt.listchars:append('space:⋅')
vim.opt.listchars:append('eol:↴')

require('hlchunk').setup({
	chunk = {
		enable = true,
		use_treesitter = true,
		style = {
			{ fg = '#806d9c' },
		},
	},
	indent = {
		chars = { '│', '¦', '┆', '┊' },
		use_treesitter = false,
	},
	blank = {
		enable = false,
	},
	line_num = {
		use_treesitter = true,
	},
})
