"
" Author: linluk  'lukas42singer (at) gmail (dot) com'
" Created: 2018/02/10
" Filename: c2h.vim
" License: Copyright (C) 2018 Lukas Singer
"          WTFPL see <COPYING> for more info.
"
" c2h is a small vim plugin to switch between c/c++ source and header files.
"

if exists("g:c2h_loaded")
  "finish
endif
let g:c2h_loaded = 1

command! C2H call C2H()
command! -nargs=+ C2HRegister call C2H_Register(<f-args>)
command! C2HClear call C2H_Clear()
command! C2HReset call C2H_Reset()
command! C2HAbout call C2H_About()

nnoremap <leader>ch :C2H<CR>

let g:c2h_exts = {}

function! C2H_Clear()
  let g:c2h_exts = {}
endfunction

function! C2H_Reset()
  call C2H_Clear()
  call C2H_Register('c', 'h')
  call C2H_Register('C', 'H')
  call C2H_Register('cpp', 'h')
  call C2H_Register('cpp', 'hpp')
  call C2H_Register('CPP', 'H')
  call C2H_Register('CPP', 'HPP')
  call C2H_Register('cc', 'h')
  call C2H_Register('cc', 'hpp')
  call C2H_Register('CC', 'H')
  call C2H_Register('CC', 'HPP')
  call C2H_Register('cxx', 'h')
  call C2H_Register('cxx', 'hpp')
  call C2H_Register('CXX', 'H')
  call C2H_Register('CXX', 'HPP')
endfunction

function! C2H_Register(...)
  function! C2H_RegisterInternal(ext1, ext2)
    if has_key(g:c2h_exts, a:ext1)
      if index(get(g:c2h_exts, a:ext1), a:ext2) == -1
        call add(get(g:c2h_exts, a:ext1), a:ext2)
      endif
    else
      let g:c2h_exts[a:ext1] = [a:ext2]
    endif
  endfunction
  let [e1, e2] = a:000
  if e1 == e2
    echoerr "c2h: adding a self referencing pair is not allowed!"
  else
    call C2H_RegisterInternal(e1, e2)
    call C2H_RegisterInternal(e2, e1)
  endif
endfunction

function! C2H()
  let l:ext = expand("%:e")
  if has_key(g:c2h_exts, l:ext)
    let l:exts = g:c2h_exts[l:ext]
    let l:dir = substitute(expand("%:p:h"), "/(source|sources|src|header|headers|include)/", "/**/", "g")
    let l:file = l:dir . "/" . expand("%:t:r")
    for ext in l:exts
      if !exists("l:first")
        let l:first = ext
      endif
      for target in glob(l:file . "." . ext, 0, 1)
        let l:found = 1
        execute "edit " . target
      endfor
    endfor
    if !exists("l:found")
      if exists("l:first")
        execute "edit " . expand("%:t:r") . "." . l:first
      endif
    endif
  endif
endfunction

function! C2H_About()
  echom "<c2h> Copyright (C) 2018 Lukas Singer"
  echom "This program comes with ABSOLUTELY NO WARRANTY;"
  echom "This is free software, and you are welcome to redistribute it;"
  echom " "
  echom "usage:"
  echom "  <leader>ch  or  :C2H          switch between source and header file"
  echom "  :C2HAbout                     prints this help text"
  echom "  :C2HRegister <arg1> <arg2>    registers corresponding source and header extensions"
  echom "  :C2HClear                     removes all file extension mappings"
  echom "  :C2HReset                     resets all file extension mappings"
  echom " "
  echom "thanks for using vim-c2h"
  echom "visit: <https://github.com/linluk/vim-c2h>"
  echom " "
  echom "registered extensions"
  for ext in keys(g:c2h_exts)
    echom " " . ext . ": [" . join(g:c2h_exts[ext], ", ") . "]"
  endfor
  echom " "
endfunction

call C2H_Reset()

