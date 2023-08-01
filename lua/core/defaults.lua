require('core.disabled')
require('core.kepmappings')
require('core.statusline')
local opt, fn = vim.opt, vim.fn

-- vim set
opt.cursorline = true
opt.eb = false
-- opt.colorcolumn = '80'
opt.background = 'dark'
opt.backup = false
opt.breakindent = true
opt.breakindentopt = 'shift:2'
opt.encoding = 'utf-8'
opt.laststatus = 3
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
-- opt.mousemoveevent = true
opt.scrolloff = 5
opt.tabstop = 4
opt.shiftwidth = 0
-- opt.expandtab = true
opt.ttimeoutlen = 20
opt.termguicolors = true
opt.updatetime = 100
opt.visualbell = true
opt.wildmenu = true
opt.wildmode = { 'longest:full', 'full' }
opt.writebackup = false
opt.diffopt:append('algorithm:patience')
opt.list = true
-- stylua: ignore start
opt.listchars = {
  tab         = '→ ',
  extends     = '…',
  precedes    = '…',
  nbsp        = '␣',
  trail       = '·',
	eol         = '󱞣',
	-- eol         = '↴',
}
opt.fillchars = {
  fold        = '·',
  foldopen    = '',
  foldclose   = '',
  foldsep     = ' ',
  diff        = '╱',
  eob         = ' ',
}
opt.fillchars = {
	horiz       = '━',
	horizup     = '┻',
	horizdown   = '┳',
	vert        = '┃',
	vertleft    = '┫',
	vertright   = '┣',
	verthoriz   = '╋',
}
-- stylua: ignore end

if fn.has('nvim') then
	opt.inccommand = 'split'
end

-- Use patience algorithm for diffing
local config_path = fn.stdpath('config')
local backup_path = config_path .. '/tmp/backup'
local undo_path = config_path .. '/tmp/undo'
if fn.isdirectory(backup_path) == 0 then
	fn.mkdir(backup_path, 'p')
end
if fn.isdirectory(undo_path) == 0 then
	fn.mkdir(undo_path, 'p')
end

opt.backup = true
opt.backupdir = backup_path
if vim.fn.has('persistent_undo') then
	opt.undofile = true
	opt.undodir = undo_path
end
