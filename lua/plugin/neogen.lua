require('neogen').setup({
	enabled = true,
	languages = {
		lua = { template = { annotation_convention = 'emmylua' } },
		python = { template = { annotation_convention = 'reST' } },
		sh = { template = { annotation_convention = 'google_bash' } },
		c = { template = { annotation_convention = 'doxygen' } },
		cpp = { template = { annotation_convention = 'doxygen' } },
		go = { template = { annotation_convention = 'godoc' } },
		java = { template = { annotation_convention = 'javadoc' } },
		javascript = { template = { annotation_convention = 'jsdoc' } },
		kotlin = { template = { annotation_convention = 'kdoc' } },
		typescript = { template = { annotation_convention = 'tsdoc' } },
		rust = { template = { annotation_convention = 'rustdoc' } },
	},
})
local opts = { silent = true }
vim.keymap.set('n', '<Leader>rr', ":lua require('neogen').generate()<CR>", opts)
vim.keymap.set('i', '<C-j>', [[<Cmd>lua require('neogen').jump_next()<CR>]])
vim.keymap.set('i', '<C-k>', [[<Cmd>lua require('neogen').jump_prev()<CR>]])
vim.keymap.set('n', '<Leader>dg', [[:Neogen<Space>]], { silent = false })
