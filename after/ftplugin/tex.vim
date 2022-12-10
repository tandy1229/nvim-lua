filetype plugin indent on
syntax enable

let g:tex_flavor = 'latex'
let g:vimtex_view_method = 'zathura'
let g:vimtex_view_general_viewer = 'zathura'

let maplocalleader = ","

let g:vimtex_toc_config = {
      \ 'name' : 'TOC',
      \ 'layers' : ['content', 'todo', 'include'],
      \ 'resize' : 1,
      \ 'split_width' : 25,
      \ 'todo_sorted' : 0,
      \ 'show_help' : 1,
      \ 'show_numbers' : 1,
      \ 'mode' : 2,
      \ }
