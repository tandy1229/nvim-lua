require('fzf-lua').setup({
	lsp = {
		-- make lsp requests synchronous so they work with null-ls
		async_or_timeout = 3000,
	},
	-- winopts = {
	-- 	height = 0.95,
	-- 	width = 0.95,
	-- },
})

local keymap = vim.keymap

keymap.set('n', '<Leader>lf', '<cmd>FzfLua files<CR>', { silent = true })
keymap.set('n', '<Leader>lr', '<cmd>FzfLua grep_project<CR>', { silent = true })
keymap.set('n', '<Leader>lh', '<cmd>FzfLua oldfiles cwd=~<CR>', { silent = true })
keymap.set('n', '<Leader>la', '<cmd>FzfLua builtin<CR>', { silent = true })
keymap.set('n', '<Leader>ll', '<cmd>FzfLua lines<CR>', { silent = true })
keymap.set('n', 'z=', '<cmd>FzfLua spell_suggest<CR>', { silent = true })
keymap.set('n', '<Leader>lb', '<cmd>FzfLua buffers<CR>', { silent = true })
keymap.set('n', '<Leader>;', '<cmd>FzfLua command_history<CR>', { silent = true })

-- vim.cmd([[
-- augroup fzf_commands
--   autocmd!
--   autocmd FileType fzf tnoremap <silent> <buffer> <c-j> <down>
--   autocmd FileType fzf tnoremap <silent> <buffer> <c-k> <up>
-- augroup end
-- ]])
