vim.wo.spell = true
local keymap = vim.keymap

keymap.set('n', '<Leader><Leader>', '<Esc>/<++><CR>:nohlsearch<CR>cgn')

keymap.set('i', ',f', '<Esc>/<++><CR>:nohlsearch<CR>', { buffer = true })
keymap.set('i', ',w', '<Esc>/ <++><CR>:nohlsearch<CR>', { buffer = true })
keymap.set('i', ',n', '---<Enter><Enter>', { buffer = true })
keymap.set('i', ',b', '**** <++><Esc>F*;i', { buffer = true })
keymap.set('i', ',s', '~~~~ <++><Esc>F~;i', { buffer = true })
keymap.set('i', ',i', '** <++><Esc>F*i', { buffer = true })
keymap.set('i', ',d', '`` <++><Esc>F`i', { buffer = true })
keymap.set('i', ',c', '```<Enter><++><Enter>```<Enter><Enter><++><Esc>4kA', { buffer = true })
keymap.set('i', ',m', '- [ ]', { buffer = true })
keymap.set('i', ',p', '![](<++>) <++><Esc>F[a', { buffer = true })
keymap.set('i', ',a', '[](<++>) <++><Esc>F[a', { buffer = true })
keymap.set('i', ',1', '#<Space><Enter><Enter><++><Esc>2kA', { buffer = true })
keymap.set('i', ',2', '##<Space><Enter><Enter><++><Esc>2kA', { buffer = true })
keymap.set('i', ',3', '###<Space><Enter><Enter><++><Esc>2kA', { buffer = true })
keymap.set('i', ',4', '####<Space><Enter><Enter><++><Esc>2kA', { buffer = true })
keymap.set('i', ',5', '#####<Space><Enter><Enter><++><Esc>2kA', { buffer = true })
keymap.set('i', ',l', '--------<Enter>', { buffer = true })
