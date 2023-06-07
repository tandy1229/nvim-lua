require('core.disabled')
require('core.kepmappings')
require('core.statusline')
local o, opt, fn = vim.o, vim.opt, vim.fn

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

if fn.has('nvim') then
	opt.inccommand = 'split'
end
