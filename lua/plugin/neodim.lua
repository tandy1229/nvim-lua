require('neodim').setup({
	refresh_delay = 75, -- time in ms to wait after typing before refresh diagnostics
	alpha = 0.75,
	blend_color = '#000000',
	priority = 100,
	hide = {
		virtual_text = true,
		signs = true,
		underline = true,
	},
})
