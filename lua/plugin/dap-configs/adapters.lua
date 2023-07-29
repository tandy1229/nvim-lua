local adapters = {}

adapters.nlua = function(callback, config)
	callback({
		type = 'server',
		host = config.host or '127.0.0.1',
		port = config.port or 8086,
	})
end

return adapters
