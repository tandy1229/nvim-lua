require('treesj').setup({
	use_default_keymaps = false,
})

local langs = require('treesj.langs')['presets']

vim.api.nvim_create_autocmd({ 'FileType' }, {
	pattern = '*',
	callback = function()
		local opts = { buffer = true }
		if langs[vim.bo.filetype] then
			vim.keymap.set('n', 'gS', '<Cmd>TSJSplit<CR>', opts)
			vim.keymap.set('n', 'gJ', '<Cmd>TSJJoin<CR>', opts)
		else
			vim.keymap.set('n', 'gS', '<Cmd>SplitjoinSplit<CR>', opts)
			vim.keymap.set('n', 'gJ', '<Cmd>SplitjoinJoin<CR>', opts)
		end
	end,
})
