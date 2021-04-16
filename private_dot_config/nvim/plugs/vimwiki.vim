" Todas essas coisas em :help vimwiki
" path: Caminho para wiki
" index: Nome do arquivo inical da wiki
" diary_rel_path: Caminho relativo para a pasta de diários
" diary_index: Caminho relativo (a partir da vravel anterior) para o index
" diary_header: Título do índice
" diary_caption_level: Nível dos títulos q serão mostrados no índice
" syntax: Sintaxe da wiki
" links_space_char: Separador entre os nomes dos arquivos da wiki 
" 	Ex: O novo jogo -> O_novo_jogo
" ext: Extensão dos arquivos da wiki
let g:wiki = {}
let wiki.path = '$LC' " Variável de ambiente
let wiki.index = 'Entrada/Entrada'
let wiki.diary_rel_path = 'Áreas/Jornal/'
let wiki.diary_index = 'Jornal'
let wiki.diary_header = 'FON'
let wiki.diary_caption_level = 0
let wiki.syntax = 'markdown'
let wiki.links_space_char = '-'
let wiki.ext = '.md'
let g:vimwiki_list = [wiki]

" Desabilitar ler arquivos de extensão .md fora do diretório wiki como se
" fossem outras wikis
let g:vimwiki_global_ext = 0

" Símbolos para mostrar progresso de todo lists
let g:vimwiki_listsyms = '✗○◐●✓'

" Esconder formatações de códigos
let g:vimwiki_conceal_pre = 1

" Nomes dos meses 
let g:vimwiki_diary_months = {
      \ 1: 'Janeiro', 2: 'Fevereiro', 3: 'Março',
      \ 4: 'Abril', 5: 'Maio', 6: 'Junho',
      \ 7: 'Julho', 8: 'Agosto', 9: 'Setembro',
      \ 10: 'Outubro', 11: 'Novembro', 12: 'Dezembro'
      \ }

" Nome da tabela de conteúdos
let g:vimwiki_toc_header = 'Conteúdo'

" Nome dos links gerados automaticamente
let g:vimwiki_links_header = 'Subcousas'

" Cabeçalho gerado automaticamente (1 = #, 2 = ##, 3 = ###)
" (pode ser 0)
let g:vimwiki_auto_header = 1

" Salvar automaticamente arquivo quando sair dele; n funciona individualmente 
" com o set hidden mas, se vc sair do vim, ele salva tudo.
let g:vimwiki_autowriteall = 1

" Remapear ir pro próximo link pra <Leader>n
nmap <Leader>n <Plug>VimwikiNextLink
nmap <Leader>N <Plug>VimwikiPrevLink

command! CDirWiki execute ":cd ".expand(vimwiki_list[0].path)
nmap <leader>cC :CDirWiki<cr>:pwd<cr>

nmap <leader>Rd :CDirWiki<cr>:read Sobre/modelos/diur.md<cr>
nmap <leader>Rn :CDirWiki<cr>:read Sobre/modelos/notur.md<cr>

" | Auxiliares |

" Manejar os links de forma a permitir acessar quaisquer arquivos de qualquer
" lugar da wiki. Ou seja, assume-se que todos tenham nomes únicos e procura
" por eles.
" Usa: Fd para achar o arquivo
function! VimwikiLinkHandler(link)
  try
    let result = system('caminho.lua ' .
        \ shellescape(a:link))
    "let result = system('fd -F -e .md '.
    "      \ shellescape(a:link)." ".
    "      \ shellescape(expand(g:vimwiki_list[0].path)))
    if !len(l:result)
      return 0
    endif
    let result = split(l:result, '\n',)[0]  "Se tiver mais de um
    execute "edit " l:result
    return 1
  catch
    echo "Erro no link Handler"
  endtry
  return 0
endfunction


" Recebe um caminho (pode ser do fzf) e printa, no cursor, um link para esse
" arquivo
function! PasteWikiLink(path)
  " Testa se estiver vazio
  if !len(a:path) 
    echomsg("No path given")
    return
  endif
  " Nome do arquivo, expand pra deixar espaços
  let formatted=expand(fnamemodify(a:path, ':t:r'))
  let linkFormat = "[[" . l:formatted . "]]"
  " deleta todas as aspas
  "let linkFormat=substitute(linkFormat,"\"","","g")
  "Insere a variável no lugar em q o cursors etá
  exec "norm a" . l:linkFormat . " "
endfunction
command! -nargs=* PasteLink call PasteWikiLink(<q-args>)

function! GenerateLinksCurrent()
  let l:path=expand('%:p')
  let l:path=substitute(path,expand(g:vimwiki_list[0].path),"","")
  let l:path=substitute(path,"/","","")
  let l:path=substitute(path,".md","","")
  exec "VimwikiGenerateLinks " "/" . path . "/*.md"
endfunction
command! GenerateLinks call GenerateLinksCurrent()

function! TermNNN(path)
  " Pasta em q a nota está
  let l:folder=fnamemodify( a:path, ':h' )    
  exec "normal :term nnn " . l:folder . "\<cr>" 
endfunction
command! -nargs=* OpenNNN call TermNNN(<q-args>)

" Cor onedark para o header
hi VimwikiHeader1 guifg=#61AFEF
hi VimwikiHeader2 guifg=#61AFEF
hi VimwikiHeader3 guifg=#61AFEF
hi VimwikiHeader4 guifg=#61AFEF
hi VimwikiHeader5 guifg=#61AFEF
hi VimwikiHeader6 guifg=#61AFEF
