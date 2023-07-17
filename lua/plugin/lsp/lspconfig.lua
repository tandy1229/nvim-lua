--[[/* UI */]]

-- vim.cmd([[
-- 	sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=
-- 	sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn linehl= numhl=
-- 	sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo linehl= numhl=
-- 	sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=
-- ]])

-- lsp sign
vim.fn.sign_define('DiagnosticSignError', {text='', texthl='DiagnosticSignError'})
vim.fn.sign_define('DiagnosticSignWarn', {text='', texthl='DiagnosticSignWarn'})
vim.fn.sign_define('DiagnosticSignInfo', {text='', texthl='DiagnosticSignInfo'})
vim.fn.sign_define('DiagnosticSignHint', {text='', texthl='DiagnosticSignHint'})

--- Configuration for `nvim_open_win`
local FLOAT_CONFIG = { border = 'rounded' }

vim.diagnostic.config({
	float = FLOAT_CONFIG,
	underline = true,
	severity_sort = true,
	signs = true,
	virtual_text = { prefix = ' ', source = 'if_many', spacing = 4 },
})


require('lspconfig.ui.windows').default_options = FLOAT_CONFIG

-- Setup language servers.
require('neodev').setup({})
local lspconfig = require('lspconfig')
lspconfig.pyright.setup({})
lspconfig.tsserver.setup({})
lspconfig.gopls.setup({})
lspconfig.bashls.setup({})
lspconfig.clangd.setup({})
lspconfig.lua_ls.setup({
	settings = {
		Lua = {
			runtime = {
				version = 'LuaJIT',
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { 'vim' },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file('', true),
				checkThirdParty = false,
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
})
lspconfig.rust_analyzer.setup({
	-- Server-specific settings. See `:help lspconfig-setup`
	settings = {
		['rust-analyzer'] = {},
	},
})

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('UserLspConfig', {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf }
		vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
		vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
		vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
		vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
		vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
		vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
		vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
		vim.keymap.set('n', '<space>wl', function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, opts)
		vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
		vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
		vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
		vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
		vim.keymap.set('n', '<space>f', function()
			vim.lsp.buf.format({ async = true })
		end, opts)
	end,
})
