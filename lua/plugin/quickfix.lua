require('qf').setup({})
vim.cmd([[
nnoremap <leader>co <cmd>lua require'qf'.open('c')<CR> " Open quickfix list
nnoremap <leader>cc <cmd>lua require'qf'.close('c')<CR> " Close quickfix list

nnoremap <leader>cj <cmd>lua require'qf'.below('l')<CR> " Go to next location list entry from cursor
nnoremap <leader>ck <cmd>lua require'qf'.above('l')<CR> " Go to previous location list entry from cursor

nnoremap <leader>cJ <cmd>lua require'qf'.below('c')<CR> " Go to next quickfix entry from cursor
nnoremap <leader>cK <cmd>lua require'qf'.above('c')<CR> " Go to previous quickfix entry from cursor

nnoremap ]q <cmd>lua require'qf'.below('visible')<CR> " Go to next entry from cursor in visible list
nnoremap [q <cmd>lua require'qf'.above('visible')<CR> " Go to previous entry from cursor in visible list
]])
