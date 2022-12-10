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
		'help',
		'markdown',
		'markdown_inline',
	},

	-- Install parsers synchronously (only applied to `ensure_installed`)
	sync_install = false,

	-- Automatically install missing parsers when entering buffer
	-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
	auto_install = true,
	highlight = {
		enable = true,
		disable = { 'rust', 'latex' },
		additional_vim_regex_highlighting = false,
	},
})
