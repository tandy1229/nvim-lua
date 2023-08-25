require('mason-nvim-dap').setup({
	ensure_installed = { 'python', 'cppdbg', 'bash', 'codelldb' },
	handlers = {
		function(config)
			require('mason-nvim-dap').default_setup(config)
		end,
		cppdbg = function(config)
			config.configurations = {
				{
					name = 'Launch file',
					type = 'cppdbg',
					request = 'launch',
					program = function()
						return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
					end,
					cwd = '${workspaceFolder}',
					stopAtEntry = true,
				},
				{
					name = 'Attach to lldb-mi :1234',
					type = 'cppdbg',
					request = 'launch',
					MIMode = 'lldb',
					cwd = '${workspaceFolder}',
					program = function()
						return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
					end,
				},
			}
			require('mason-nvim-dap').default_setup(config) -- don't forget this!
		end,
	},
})
