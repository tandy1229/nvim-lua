require('neogen').setup({})
local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap('n', '<Leader>rr', ":lua require('neogen').generate()<CR>", opts)
