local adapters = {}

adapters.nlua = function(callback, config)
	callback({
		type = 'server',
		host = config.host or '127.0.0.1',
		port = config.port or 8086,
	})
end

adapters.lldb = {
	type = 'executable',
	command = '/usr/local/opt/llvm/bin/lldb-vscode', -- adjust as needed, must be absolute path
	name = 'lldb',
}

return adapters
