require('luasnip.loaders.from_vscode').lazy_load()
local luasnip = require('luasnip')
local types = require('luasnip.util.types')

luasnip.setup({
	-- Display a cursor-like placeholder in unvisited nodes
	-- of the snippet.
	ext_opts = {
		[types.insertNode] = {
			unvisited = {
				virt_text = { { '|', 'Conceal' } },
				virt_text_pos = 'inline',
			},
		},
		-- This is needed because LuaSnip differentiates between $0 and other
		-- placeholders (exitNode and insertNode). So this will highlight the last
		-- jump node.
		[types.exitNode] = {
			unvisited = {
				virt_text = { { '|', 'Conceal' } },
				virt_text_pos = 'inline',
			},
		},
	},
})
