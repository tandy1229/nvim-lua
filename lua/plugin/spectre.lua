vim.keymap.set('n', '<Leader>S', "<cmd>lua require('spectre').open()<CR>")
vim.keymap.set('n', '<Leader>sw', "<cmd>lua require('spectre').open_visual({select_word=true})<CR>")
vim.keymap.set('v', '<Leader>s', "<esc>:lua require('spectre').open_visual()<CR>")
vim.keymap.set('n', '<Leader>sp', "viw:lua require('spectre').open_file_search()<CR>")
