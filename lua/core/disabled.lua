local g = vim.g
-- languange support disable
g.loaded_ruby_provider = 0
g.loaded_python3_provider = 0
g.loaded_node_provider = 0
g.loaded_perl_provider = 0

-- Disable some builtin vim plugins
local disabled_built_ins = {
	'2html_plugin',
	'getscript',
	'getscriptPlugin',
	'gzip',
	'logipat',
	'netrw',
	'netrwPlugin',
	'netrwSettings',
	'netrwFileHandlers',
	'matchit',
	'matchparen',
	'tar',
	'tarPlugin',
	'rrhelper',
	'vimball',
	'vimballPlugin',
	'zip',
	'zipPlugin',
}

for _, plugin in pairs(disabled_built_ins) do
	g['loaded_' .. plugin] = 1
end
