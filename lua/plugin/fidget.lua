require('fidget').setup({
	text = { spinner = 'dots' },
	fmt = {
		fidget = function(fidget_name, spinner)
			return string.format('%s %s', spinner, fidget_name)
		end,
		task = function(_)
			return nil
		end,
	},
})
