vim.g.rnvimr_ex_enable = 1
vim.g.rnvimr_pick_enable = 1
vim.g.rnvimr_draw_border = 0
vim.g.rnvim_shadow_winblend = 70
vim.g.rnvimr_edit_cmd = 'drop'
vim.g.rnvimr_action = {
	['<C-t>'] = 'NvimEdit tab drop',
	['<C-s>'] = 'NvimEdit split true',
	['<C-v>'] = 'NvimEdit vsplit true',
	['<C-o>'] = 'NvimEdit drop true',
	gw = 'JumpNvimCwd',
	yw = 'EmitRangerCwd',
}
-- vim.g.rnvimr_layout = {
--     relative = 'editor',
--     width = vim.o.columns,
--     height = vim.o.lines,
--     style = 'minimal'
-- }
vim.g.rnvimr_ranger_views = {
	{ minwidth = 90, ratio = {} },
	{ minwidth = 50, maxwidth = 89, ratio = { 1, 1 } },
	{ maxwidth = 49, ratio = { 1 } },
}

-- vim.g.rnvimr_presets = {
--     width = 1.0,
--     height = 1.0,
-- }

-- vim.keymap.set('n', 'R', ':RnvimrToggle<CR><C-\\><C-n>:RnvimrResize 0<CR>', {silent = true})
vim.keymap.set('n', 'R', ':RnvimrToggle<CR>', { silent = true })
