vim.api.nvim_buf_set_keymap(0, 'n', '\r', "<cmd>CompilerOpen<cr>", { noremap = true, silent = true })

vim.api.nvim_buf_set_keymap(0, 'n', '<F6>', "<cmd>CompilerToggleResults<cr>", { noremap = true, silent = true })
