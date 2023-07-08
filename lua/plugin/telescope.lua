local actions = require('telescope.actions')

local telescope = require('telescope')

telescope.setup({
	defaults = {
		prompt_prefix = '   ',
		selection_caret = '→ ',
		dynamic_preview_title = true,
		layout_strategy = 'flex',
		layout_config = {
			horizontal = {
				prompt_position = 'top',
				width = 0.8,
				height = 0.8,
				preview_width = 0.5,
			},
			vertical = {
				prompt_position = 'top',
				width = 0.8,
				height = 0.8,
				mirror = true,
			},
		},
		sorting_strategy = 'ascending',
		file_ignore_patterns = { '.git/', '.cache', '%.class', '%.pdf', '%.mkv', '%.mp4', '%.zip' },

		file_previewer = require('telescope.previewers').vim_buffer_cat.new,
		grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
		qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
		file_sorter = require('telescope.sorters').get_fuzzy_file,
		generic_sorter = require('telescope.sorters').get_generic_fuzzy_sorter,
		mappings = {
			i = {
				['<C-c>'] = actions.close,
				['<C-j>'] = actions.move_selection_next,
				['<C-k>'] = actions.move_selection_previous,
				['<C-n>'] = actions.move_selection_next,
				['<C-p>'] = actions.move_selection_previous,
				['<C-q>'] = actions.smart_send_to_qflist + actions.open_qflist,
				['<C-a>'] = actions.send_to_qflist + actions.open_qflist,
				['<c-f>'] = actions.to_fuzzy_refine,
				['<Esc>'] = actions.close,
				['<Tab>'] = actions.select_default + actions.center,
				['<C-t>'] = actions.select_tab_drop,
				['<C-v>'] = actions.file_vsplit,
				['<C-h>'] = actions.file_split,
			},
			n = {
				['<C-q>'] = actions.send_selected_to_qflist + actions.open_qflist,
				['<C-a>'] = actions.send_to_qflist + actions.open_qflist,
			},
		},
		extensions = {
			fzf = {
				fuzzy = true,
				override_generic_sorter = true,
				override_file_sorter = true,
				case_mode = 'smart_case',
			},
		},
	},
})
require('telescope').load_extension('fzf')
require('telescope').load_extension('notify')
require('telescope').load_extension('undo')
-- require('telescope').load_extension('frecency')
-- require('telescope').load_extension('file_browser')
-- " "
