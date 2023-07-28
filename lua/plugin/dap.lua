local dap = require('dap')
local dapui = require('dapui')
dapui.setup()
require('nvim-dap-virtual-text').setup({})

local m = { noremap = true }
vim.keymap.set('n', '<leader>dq', ':Telescope dap<CR>', m)
vim.keymap.set('n', '<leader>dt', dap.toggle_breakpoint, m)
vim.keymap.set('n', '<leader>dn', dap.continue, m)
vim.keymap.set('n', '<leader>ds', dap.terminate, m)
vim.keymap.set('n', '<leader>du', dapui.toggle, m)
vim.keymap.set('n', '<F1>', dap.up, { noremap = true })
vim.keymap.set('n', '<F2>', dap.down, { noremap = true })
vim.keymap.set('n', '<F5>', dap.continue, { noremap = true })
vim.keymap.set('n', '<F6>', dap.pause, { noremap = true })
vim.keymap.set('n', '<F8>', dap.repl.open, { noremap = true })
vim.keymap.set('n', '<F9>', dap.toggle_breakpoint, { noremap = true })
vim.keymap.set('n', '<F10>', dap.step_over, { noremap = true })
vim.keymap.set('n', '<F11>', dap.step_into, { noremap = true })

vim.fn.sign_define(
	'DapBreakpoint',
	{ text = ' ', texthl = 'DapBreakpoint', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' }
)
vim.fn.sign_define(
	'DapBreakpointCondition',
	{ text = '◆ ', texthl = 'DapBreakpoint', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' }
)
vim.fn.sign_define(
	'DapBreakpointRejected',
	{ text = '', texthl = 'DapBreakpoint', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' }
)
vim.fn.sign_define('DapLogPoint', {
	text = '󰦪',
	texthl = 'DapLogPoint',
	linehl = 'DapLogPoint',
	numhl = 'DapLogPoint',
})
vim.fn.sign_define('DapStopped', { text = '', texthl = 'DapStopped', linehl = 'DapStopped', numhl = 'DapStopped' })

-- dap.adapters = require('plugin.dap-configs.adapters')
-- dap.configurations = require('plugin.dap-configs.configurations')
