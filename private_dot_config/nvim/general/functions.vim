
" Abrir arquivo pelo WSL
function! OpenFile(path)
  silent exec "!xdg-open ".a:path
endfunction

command! -nargs=* Open call OpenFile(<q-args>)

function! ProjDaTaf()
    let path=system('projDaTaf.lua' . ' ' . expand('%'))
    execute('edit ' . path)
endfunction

command! -nargs=* TafProj call ProjDaTaf()
