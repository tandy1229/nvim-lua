--
-- init files for neovim 0.8.0+
--
local g, api = vim.g, vim.api

pcall(require, 'impatient')
require('core.config')

-- plugin manage packer
require('plugin.packer')

-- vim files load
api.nvim_command('runtime init/init.vim')
-- personal setting
g.python3_host_prog = '/usr/local/bin/python3.11'

g.vimtex_view_method = 'zathura'

--     
--
-- use the global statusline
-- vim.o.laststatus = 3
