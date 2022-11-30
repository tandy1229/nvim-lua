--
-- init files for neovim 0.8.0+
--
local g, api = vim.g, vim.api

require('impatient')
require('config')
require('kepmappings')
require('statusline')

-- plugin manage packer
require('plugin.packer')

--     
--
-- use the global statusline
-- vim.o.laststatus = 3

-- vim files load

api.nvim_command('runtime init/init.vim')
g.python3_host_prog = '/usr/local/bin/python3.11'
