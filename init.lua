--
-- init files for neovim 0.8.0+
--
--

vim.loader.enable()
require('core.defaults')

-- plugin manage lazy
require('init.lazy')

-- vim files load
-- vim.api.nvim_command('runtime init/init.vim')

-- personal setting
-- g.python3_host_prog = '/usr/local/bin/python3.11'

--     
--
-- use the global statusline
-- vim.o.laststatus = 3
