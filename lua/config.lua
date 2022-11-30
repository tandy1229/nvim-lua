local g, o, opt, fn = vim.g, vim.o, vim.opt, vim.fn

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

-- vim set
opt.background = 'dark'
opt.backup = false
opt.breakindent = true
opt.breakindentopt = 'shift:2'
-- opt.colorcolumn = '80'
o.encoding = 'utf-8'
opt.hidden = true
opt.ignorecase = true
opt.lazyredraw = true
opt.linebreak = true
opt.number = true
-- opt.notimeout = true
opt.relativenumber = true
opt.showmode = false
opt.smartcase = true
opt.smartindent = true
opt.splitbelow = true
opt.splitright = true
opt.signcolumn = 'yes'
opt.scrolloff = 5
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.ttimeoutlen = 0
opt.termguicolors = true
opt.updatetime = 100
opt.visualbell = true
opt.wildmenu = true
opt.wildmode = { 'longest:full', 'full' }
opt.writebackup = false

-- languange support disable
g.loaded_ruby_provider = 0
g.loaded_node_provider = 0
g.loaded_perl_provider = 0

if fn.has('nvim') then
	opt.inccommand = 'split'
end

vim.api.nvim_command('colorscheme deus')

-- terminal colors: make it not change by some plugin
-- g.terminal_color_0  = '#000000'
g.terminal_color_0  = '#21222C'
g.terminal_color_1  = '#FF5555'
g.terminal_color_2  = '#50FA7B'
g.terminal_color_3  = '#F1FA8C'
g.terminal_color_4  = '#BD93F9'
g.terminal_color_5  = '#FF79C6'
g.terminal_color_6  = '#8BE9FD'
g.terminal_color_7  = '#BFBFBF'
g.terminal_color_8  = '#4D4D4D'
g.terminal_color_9  = '#FF6E67'
g.terminal_color_10 = '#5AF78E'
g.terminal_color_11 = '#F4F99D'
g.terminal_color_12 = '#CAA9FA'
g.terminal_color_13 = '#FF92D0'
g.terminal_color_14 = '#9AEDFE'
g.terminal_color_15 = '#FFFFFF'
