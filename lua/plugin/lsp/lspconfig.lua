--[[/* UI */]]

local lspconfig = require('lspconfig')
-- local util = require('lspconfig.util')

-- lsp sign
vim.fn.sign_define('DiagnosticSignError', { text = '', texthl = 'DiagnosticSignError' })
vim.fn.sign_define('DiagnosticSignWarn', { text = '', texthl = 'DiagnosticSignWarn' })
vim.fn.sign_define('DiagnosticSignInfo', { text = '', texthl = 'DiagnosticSignInfo' })
vim.fn.sign_define('DiagnosticSignHint', { text = '', texthl = 'DiagnosticSignHint' })

vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(ev)
		if vim.lsp.get_client_by_id(ev.data.client_id).server_capabilities.inlayHintProvider then
			vim.lsp.inlay_hint(ev.buf, true)
			vim.api.nvim_buf_set_keymap(ev.buf, 'n', '<C-c>', '', {
				callback = function()
					vim.lsp.inlay_hint(0)
				end,
			})
		end
	end,
})

--- Configuration for `nvim_open_win`
local FLOAT_CONFIG = { border = 'rounded' }

--- Event handlers
local HANDLERS = {
	['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, FLOAT_CONFIG),
	['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, FLOAT_CONFIG),
}

vim.diagnostic.config({
	float = FLOAT_CONFIG,
	underline = true,
	severity_sort = true,
	signs = true,
	virtual_text = { prefix = ' ', source = 'if_many', spacing = 4 },
})

require('lspconfig.ui.windows').default_options = FLOAT_CONFIG

--- @param lsp string
--- @param config? table
local function setup(lsp, config)
	if config == nil then
		config = {}
	end

	config.handlers = HANDLERS
	lspconfig[lsp].setup(config)
end

-- Setup language servers.
-- lua
require('neodev').setup({})

-- lspconfig.pyright.setup({})
setup('pyright')
-- setup('pylyzer')
-- setup('pylsp')
setup('tsserver')
setup('sqlls')
setup('gopls')
setup('bashls')
setup('marksman')
setup('rust_analyzer')
setup('texlab')
setup('clangd', {
	-- on_attach = on_attach,
	-- capabilities = cmp_nvim_lsp.default_capabilities(),
	cmd = {
		'clangd',
		'--offset-encoding=utf-16',
	},
})
setup('lua_ls', {
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
			hint = {
				enable = true,
			},
		},
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
