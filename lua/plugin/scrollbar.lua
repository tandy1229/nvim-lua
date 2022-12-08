require('scrollbar.handlers.search').setup()
require('scrollbar').setup({
	show = true,
	handle = {
		color = '#475c53',
	},
	marks = {
		Search = { color = 'orange' },
		Misc = { color = 'purple' },
		Hint = { color = 'magenta' },
	},
})
