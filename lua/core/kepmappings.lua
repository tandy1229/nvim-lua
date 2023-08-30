local g, keymap = vim.g, vim.keymap

g.mapleader = ' '

keymap.set('n', 'S', ':update<CR>', { silent = true })
keymap.set('n', 'Q', ':q<CR>')
keymap.set('n', 'E', ':qall<CR>')
keymap.set('n', '<Leader>Q', ':qa!<CR>', { silent = true })

keymap.set('n', 'W', '5w')
keymap.set('n', 'B', '5b')

keymap.set('n', ',w', '<C-w>w')
keymap.set('n', ',h', '<C-w>h')
keymap.set('n', ',j', '<C-w>j')
keymap.set('n', ',k', '<C-w>k')
keymap.set('n', ',l', '<C-w>l')

keymap.set('n', '<up>', ':res +5<CR>')
keymap.set('n', '<down>', ':res -5<CR>')
keymap.set('n', '<left>', ':vertical resize-5<CR>')
keymap.set('n', '<right>', ':vertical resize+5<CR>')

keymap.set('n', '<', '<<')
keymap.set('n', '>', '>>')
keymap.set('n', '-', 'N')
keymap.set('n', '=', 'n')

keymap.set('n', '<Leader>sa', 'ggVG')

keymap.set('n', 'Y', 'y$')
keymap.set('v', 'Y', '"+y')

keymap.set('n', '<Leader>rc', ':e ~/.config/nvim/init.lua<CR>', { silent = true })
keymap.set('n', '<Leader>rl', ':e ~/.config/nvim/lua/init/lazy.lua<CR>', { silent = true })

keymap.set('n', '<Leader>st', ':%s/  /\t/g')
keymap.set('v', '<Leader>st', ':s/  /\t/g')
keymap.set('n', '<Leader>tt', ':%s/\t/  /g')

keymap.set('n', '<Leader>sc', ':set spell!<CR>')

keymap.set('n', '\\s', ':%s//g<left><left>')

keymap.set('n', '<Leader>/', ':sp<CR>:term<CR>')
keymap.set('n', '<F10>', '<cmd>TSHighlightCapturesUnderCursor<CR>', { silent = true })
