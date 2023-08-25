require('nvim-treesitter.configs').setup({
	textobjects = {
		select = {
			enable = true,
			lookahead = true,
			keymaps = {
				['af'] = '@function.outer',
				['if'] = '@function.inner',
				['al'] = '@loop.outer',
				['il'] = '@loop.inner',
				['ac'] = '@class.outer',
				['ic'] = { query = '@class.inner', desc = 'Select inner part of a class region' },
				['as'] = { query = '@scope', query_group = 'locals', desc = 'Select language scope' },
				['a/'] = '@comment.outer',
			},
			swap = {
				enable = true,
				swap_next = {
					['<leader>='] = '@parameter.inner',
				},
				swap_previous = {
					['<leader>-'] = '@parameter.inner',
				},
			},
			lsp_interop = {
				enable = true,
				border = 'shadow',
				peek_definition_code = {
					['<C-k>'] = '@function.outer',
				},
			},
		},
	},
})
