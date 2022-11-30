-- require('colorizer').setup()

require('ccc').setup({
	-- Your favorite settings
	highlighter = {
		auto_enable = true,
	},
})

vim.keymap.set('i', '<c-y>', '<Plug>(ccc-insert)')
vim.keymap.set('n', '<c-y>', ':CccPick<CR>')
