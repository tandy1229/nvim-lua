require('dashboard').setup({
	-- config
	-- shortcut_type = 'number',
	theme = 'hyper',
	shortcut_type = 'number',
	hide = {
		statusline = true, -- hide statusline default is true
		tabline = false, -- hide the tabline
		winbar = false, -- hide winbar
	},
	config = {
		-- footer = { '得意须尽欢' },
		footer = {},
		week_header = {
			enable = true,
		},
		project = {
			enable = true,
		},
		shortcut = {
			{ desc = '󰊳 Update', group = '@property', action = 'Lazy update', key = 'u' },
			{
				icon = ' ',
				icon_hl = 'Label',
				desc = 'Files',
				group = 'Label',
				-- action = 'Telescope find_files',
				action = 'FzfLua files',
				key = 'f',
			},
			{
				desc = ' Apps',
				group = 'deusOrange',
				action = 'Telescope app',
				key = 'a',
			},
			{
				desc = ' dotfiles',
				group = 'Number',
				action = 'Telescope dotfiles',
				key = 'd',
			},
		},
	},
})
