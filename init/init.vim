fun! s:autosave(enable)
  augroup autosave
    autocmd!
    if a:enable
      autocmd TextChanged,InsertLeave <buffer>
            \  if empty(&buftype) && !empty(bufname(''))
            \|   silent! update
            \| endif
    endif
  augroup END
endfun

" del extra whitespace
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    silent! %s/\n\+\%$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

fun! s:MakePair()
  let line = getline('.')
  let len= strlen(line)
  if line[len - 1] == ";"
    normal! lx$P
  else
    normal! lx$p
  endif
endfun

" commands
command! -nargs=0 CleanExtraSpaces :call CleanExtraSpaces()
command! -nargs=0 CompileRun :call CompileRun()
command! -bang AutoSave call s:autosave(<bang>1)

" Move the next character to the end of the line
inoremap <c-u> <ESC>:call <SID>MakePair()<CR>

if has('nvim')
    tnoremap <Esc> <C-\><C-n>
    tnoremap <C-v><Esc> <Esc>
    " highlight! link TermCursor Cursor
    " highlight! TermCursorNC guibg=red guifg=white ctermbg=1 ctermfg=15
endif

if executable('nvr')
    let $VISUAL="nvr -cc split --remote-wait +'set bufhidden=wipe'"
endif

silent !mkdir -p $HOME/.config/nvim/tmp/backup
silent !mkdir -p $HOME/.config/nvim/tmp/undo
set backupdir=$HOME/.config/nvim/tmp/backup,.
set directory=$HOME/.config/nvim/tmp/backup,.
if has('persistent_undo')
	set undofile
	set undodir=$HOME/.config/nvim/tmp/undo,.
endif

autocmd BufWritePost $MYVIMRC source $MYVIMRC
autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
