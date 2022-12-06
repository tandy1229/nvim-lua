local wilder = require('wilder')
wilder.set_option('use_python_remote_plugin', 0)
wilder.setup({ modes = { ':', '/', '?' } })

wilder.set_option('pipeline', {
	wilder.branch(
		wilder.cmdline_pipeline({
      language = 'vim',
			fuzzy = 1,
			fuzzy_filter = wilder.lua_fzy_filter(),
		}),
		wilder.vim_search_pipeline()
	),
})

local popupmenu_renderer = wilder.popupmenu_renderer(wilder.popupmenu_border_theme({
	border = 'rounded',
	highlighter = wilder.lua_fzy_highlighter(),
	left = {
		' ',
		wilder.popupmenu_devicons(),
		wilder.popupmenu_buffer_flags({
			flags = ' a + ',
			icons = { ['+'] = '', a = '', h = '' },
		}),
	},
	right = {
		' ',
		wilder.popupmenu_scrollbar(),
	},
	highlights = {
		accent = wilder.make_hl('WilderAccent', 'Pmenu', { { a = 1 }, { a = 1 }, { foreground = '#f4468f' } }),
	},
}))

local wildmenu_renderer = wilder.wildmenu_renderer({
	highlighter = wilder.lua_fzy_highlighter(),
	separator = ' · ',
	left = { ' ', wilder.wildmenu_spinner(), ' ' },
	right = { ' ', wilder.wildmenu_index() },
	highlights = {
		accent = wilder.make_hl('WilderAccent', 'Pmenu', { { a = 1 }, { a = 1 }, { foreground = '#f4468f' } }),
	},
})

wilder.set_option(
	'renderer',
	wilder.renderer_mux({
		[':'] = popupmenu_renderer,
		['/'] = wildmenu_renderer,
		substitute = wildmenu_renderer,
	})
)
