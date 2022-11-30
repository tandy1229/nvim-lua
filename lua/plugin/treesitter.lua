require('nvim-treesitter.configs').setup({
	-- A list of parser names, or "all"
	ensure_installed = {
		'c',
		'lua',
		'javascript',
		'typescript',
		'cpp',
		'python',
		'go',
		'dart',
		'regex',
		'bash',
        'java',
        'json',
        'latex',
        'gitignore',
        'sql',
        'toml',
	},

	-- Install parsers synchronously (only applied to `ensure_installed`)
	sync_install = false,

	-- Automatically install missing parsers when entering buffer
	-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
	-- auto_install = true,
	highlight = {
		enable = true,
		disable = { 'rust' },
		additional_vim_regex_highlighting = false,
	},
	rainbow = {
		enable = true,
		-- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
		extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
		max_file_lines = nil, -- Do not enable for files with more than n lines, int
		-- colors = {}, -- table of hex strings
		-- termcolors = {} -- table of colour name strings
	},
})
