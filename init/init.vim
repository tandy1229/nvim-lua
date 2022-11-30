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

" Echo the highlight group under the cursor
function! EchoHlGroup() abort
    let l:line = line(".")
	let l:col = col(".")

	echo "Highlight Group: " . synIDattr(synID(l:line, l:col, 1), "name") |
	\ echo 'Namespace: ' . synIDattr(synID(l:line, l:col, 0), "name") |
	\ echo "Linked to: " . synIDattr(synIDtrans(synID(l:line, l:col, 1)), "name")
endfunction

" commands
command! -nargs=0 CleanExtraSpaces :call CleanExtraSpaces()
command! -nargs=0 CompileRun :call CompileRun()
command! -bang AutoSave call s:autosave(<bang>1)

" press f10 to show hlgroup
nmap <F10> :call EchoHlGroup()<CR>
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

autocmd BufWritePost $MYVIMRC source $MYVIMRC
autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
