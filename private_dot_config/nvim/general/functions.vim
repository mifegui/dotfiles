
" Abrir arquivo pelo WSL
function! OpenFile(path)
  silent exec "!wsl-open '".a:path."'"
endfunction

command! -nargs=* Open call OpenFile(<q-args>)
