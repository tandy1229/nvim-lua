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
-- o.notimeout = true
-- opt.relativenumber = true
opt.showmode = false
opt.smartcase = true
opt.smartindent = true
opt.splitbelow = true
opt.splitright = true
opt.signcolumn = 'yes'
opt.scrolloff = 5
opt.tabstop = 4
opt.shiftwidth = 0
opt.expandtab = true
opt.ttimeoutlen = 20
opt.termguicolors = true
opt.updatetime = 100
opt.visualbell = true
opt.wildmenu = true
opt.wildmode = { 'longest:full', 'full' }
opt.writebackup = false
opt.fillchars = {
	horiz = '━',
	horizup = '┻',
	horizdown = '┳',
	vert = '┃',
	vertleft = '┫',
	vertright = '┣',
	verthoriz = '╋',
}

-- languange support disable
g.loaded_ruby_provider = 0
g.loaded_node_provider = 0
g.loaded_perl_provider = 0

if fn.has('nvim') then
	opt.inccommand = 'split'
end

vim.api.nvim_command('colorscheme deus')
